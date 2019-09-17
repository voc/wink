require 'net/http'
require 'json'

class TransportsController < ApplicationController
  @@KN_token = nil

  before_action :find_transport, except: [:index, :create, :new, :import_transports]

  def show
  end

  def index
    @transports = Transport.all.order('delivery_time IS NOT NULL, delivery_time DESC')
  end

  def new
    @transport = Transport.new
  end

  def create
    @transport = Transport.new(transport_params)

    if @transport.save
      redirect_to edit_transport_path
    else
      render action: 'new'
    end
  end

  def update
    if @transport.update_attributes(transport_params)
      redirect_to transports_path
    else
      render action: 'edit'
    end
  end

  def import_transports
    json = nil
    uri = URI("https://onlineservices.kuehne-nagel.com/tracking/api/my-shipments?sort=completionDate,desc&page=0&size=50&userTags=my-shipments")
    Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      req = Net::HTTP::Get.new uri
      req['Cookie'] = "ecom_app_token=" + fetch_KN_token 
      res = http.request req # Net::HTTPResponse object
      json = JSON.parse(res.body)
    end

    #puts JSON.pretty_generate(json["content"])

    json['content'].each do |values|
      transport = Transport.find_by(tracking_number: values['trackingNumber'])
      unless transport
        transport = Transport.new
        transport.shipment_id = values['shipmentId']
        transport.tracking_number = values['trackingNumber']
        transport.ordered = 1
        transport.source_address = "#{values['shipper']}\n#{values['from']}"
        transport.destination_address = "#{values['consignee']}\n#{values['to']}"
        transport.carrier = 'K&N'
        unless values['completionDate']['date'].nil?
          transport.delivery_time = Date.parse(values['completionDate']['date'])
        end
        # TODO: https://onlineservices.kuehne-nagel.com/tracking/api/shipments/130686969
      end

      transport.delivery_state = values['milestone']
      transport.save
    end

    redirect_to transports_path
  end

  private

  def find_transport
    @transport = Transport.find(params[:id])
  end

  def transport_params
    params.require(:transport).permit(:source_event_id, :source_address, :destination_event_id, :destination_address)
  end

  def fetch_KN_token
    if @@KN_token.nil?
      uri = URI("https://sso.kuehne-nagel.com/RDIApplication/login")
      res = Net::HTTP.post_form(uri, 
        'user' => ENV['KN_USER'],
        'password' => ENV['KN_PASSWORD'],
        'target' => 'https%3A%2F%2Fonlineservices.kuehne-nagel.com%2Fac%2F_sso',
        'appname' => 'ECOM',
        'mode' => 'post'
      )
      @@KN_token, = /name="appToken" value="(.+?)"/.match(res.body).captures
    end
    return @@KN_token
  end
end
