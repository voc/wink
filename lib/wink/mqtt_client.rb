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
      msg = hash['msg']

      command = msg.split(' ')

      case command[0]
      when /help/
        help =<<END
viri wink commands:
  * help
  * show (broken|missing) items
More on https://c3voc.de/wink/
END

      help.each_line do |l|
        Wink::MqttClient.send_message(l.chomp)
      end
      when /show|list/
        items = nil

        case command[1]
        when /broken/
          items = Item.all.where('deleted = ? and broken = ?', false, true)
        when /missing/
          items = Item.all.where('deleted = ? and missing = ?', false, true)
        end

        items.each do |i|
          Wink::MqttClient.send_message("#{i.case.name}: '#{i.name}' is #{command[1]}")
        end

        Wink::MqttClient.send_message("See https://c3voc.de/wink/dashboard#items for more details.")
      end
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
