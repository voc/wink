# frozen_string_literal: true

require "net/http"
require "json"

class TransportsController < ApplicationController
  KN_TOKEN_CACHE_KEY = "transports_kn_token"

  before_action :find_transport, except: %i[index create new import_transports]

  def index
    @transports = Transport.order(Arel.sql("delivery_time IS NOT NULL"), "delivery_time DESC")
  end

  def show; end

  def new
    @transport = Transport.new
  end

  def edit
    @transport.source_event_id = params[:from] unless params[:from].nil?
    return if params[:to].nil?

      @transport.destination_event_id = params[:to]
  end

  def create
    @transport = Transport.new(transport_params)

    if @transport.save
      redirect_to edit_transport_path(@transport)
    else
      render action: "new"
    end
  end

  def update
    if @transport.update(transport_params)
      @transport.save
      redirect_to transports_path
    else
      render action: "edit"
    end
  end

  def import_transports
    json = nil
    uri = URI("https://onlineservices.kuehne-nagel.com/tracking/api/my-shipments?sort=completionDate,desc&page=0&size=50&userTags=my-shipments")
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
      req = Net::HTTP::Get.new uri
      req["Cookie"] = "ecom_app_token=#{fetch_kn_token}"
      res = http.request req # Net::HTTPResponse object
      if res.is_a? Net::HTTPSuccess
        json = JSON.parse(res.body)
      else
        # token probably invalid, so clear it for next round
        Rails.cache.delete KN_TOKEN_CACHE_KEY
      end
    end

    # puts JSON.pretty_generate(json["content"])

    json["content"].each do |values|
      transport = Transport.find_by(tracking_number: values["trackingNumber"])
      unless transport
        transport = Transport.new
        transport.shipment_id = values["shipmentId"]
        transport.tracking_number = values["trackingNumber"]
        transport.ordered = 1
        transport.source_address = "#{values['shipper']}\n#{values['from'].capitalize}"
        transport.destination_address = "#{values['consignee']}\n#{values['to'].capitalize}"
        transport.carrier = "K&N"
        unless values["completionDate"]["date"].nil?
          transport.delivery_time = Date.parse(values["completionDate"]["date"])
        end
        # TODO: https://onlineservices.kuehne-nagel.com/tracking/api/shipments/130686969
      end

      transport.delivery_state = values["milestone"]
      transport.save
    end

    redirect_to transports_path
  end

  private

  def find_transport
    @transport = Transport.find(params[:id])
  end

  def transport_params
    params.expect(transport: %i[source_event_id source_address pickup_time destination_event_id
                                destination_address delivery_time])
  end

  def fetch_kn_token
    Rails.cache.fetch KN_TOKEN_CACHE_KEY, expires_in: 1.hour do
      uri = URI("https://sso.kuehne-nagel.com/RDIApplication/login")
      res = Net::HTTP.post_form(uri,
                                "user" => ENV.fetch("KN_USER", nil),
                                "password" => ENV.fetch("KN_PASSWORD", nil),
                                "target" => "https%3A%2F%2Fonlineservices.kuehne-nagel.com%2Fac%2F_sso",
                                "appname" => "ECOM",
                                "mode" => "post")
      /name="appToken" value="(.+?)"/.match(res.body)&.captures&.first if res.is_a? Net::HTTPSuccess
    end
  end
end
