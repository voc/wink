require 'mqtt'

class Wink::MqttClient
  def self.send_message(text)
    client = Wink::MqttClient.connect
    return if client.nil?

    message = {}
    message['component'] = 'wink'
    message['level'] = 'info'
    message['msg'] = text

    client.publish('/voc/alert', message.to_json)
  end

  private

  def self.connect
    begin
      client = MQTT::Client.connect("mqtts://#{Rails.configuration.mqtt['username']}:#{Rails.configuration.mqtt['password']}@#{Rails.configuration.mqtt['host']}")
    rescue
      return nil
    end
  end

end
