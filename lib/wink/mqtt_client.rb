require 'mqtt'

class Wink::MqttClient
  def self.send_message(text)
    client = Wink::MqttClient.connect
    return if client.nil?

    message = {}
    message['component'] = 'wink'
    message['level'] = 'info'
    message['msg'] = text

    if ENV['RAILS_ENV'] == 'production'
      client.publish('/voc/alert', message.to_json)
    else
      puts "MQTT: #{message}"
    end
  end

  def self.listen
    client = Wink::MqttClient.connect
    return if client.nil?

    puts "Listen to /voc/wink…"
    client.get('/voc/wink') do |topic,message|
      hash = JSON.parse(message)
      p hash
    end
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
