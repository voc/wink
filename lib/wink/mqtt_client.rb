# frozen_string_literal: true

require "mqtt"

module Wink
  class MqttClient
  def self.send_message(text)
    client = Wink::MqttClient.connect
    return if client.nil?

    message = {}
    message["component"] = "wink"
    message["level"] = "info"
    message["msg"] = text

    if ENV["RAILS_ENV"] == "production"
      client.publish("/voc/alert", message.to_json)
    else
      Rails.logger.debug { "MQTT: #{message}" }
    end
  end

  SLEEP_TIMES = [ 0.1, 0.2, 0.3, 0.4, 0.5 ].freeze
  def self.listen
    client = Wink::MqttClient.connect
    return if client.nil?

    Rails.logger.debug "Listen to /voc/wink…"
    client.get("/voc/wink") do |_topic, message|
      hash = JSON.parse(message)
      msg = hash["msg"]

      command = msg.split

      case command[0]
      when /help/
        help = <<~END_HELP
          viri wink commands:
            * help
            * show (broken|missing) items
          More on https://c3voc.de/wink/
        END_HELP

      help.each_line do |l|
        Wink::MqttClient.send_message(l.chomp)
      end
      when /show|list/
        items = nil

        case command[1]
        when /broken/
          items = Item.where("deleted = ? and broken = ?", false, true)
        when /missing/
          items = Item.where("deleted = ? and missing = ?", false, true)
        end

        items.each do |i|
          Wink::MqttClient.send_message("#{i.case.name}: '#{i.name}' is #{command[1]}")
          # to avoid flooding errors
          sleep(SLEEP_TIMES.sample)
        end

        Wink::MqttClient.send_message("See https://c3voc.de/wink/dashboard#items for more details.")
      end
    end
  end

  def self.connect
      MQTT::Client.connect("mqtts://#{Rails.configuration.mqtt['username']}:#{Rails.configuration.mqtt['password']}@#{Rails.configuration.mqtt['host']}")
  rescue StandardError
      nil
  end
  end
end
