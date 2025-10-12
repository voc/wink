# frozen_string_literal: true

namespace :wink do
  desc "send broken/missing items to mqtt server"
  task send_broken_missing_items: :environment do
    items = Item.where("deleted = ? and (broken = ? or missing = ?)", false, true, true)
    grouped_items = items.group_by { |i| i.case.name }

    if items.any?
      grouped_items.each_key do |c|
        broken_items  = grouped_items[c].filter_map { |i| i.name if i.broken == true }
        missing_items = grouped_items[c].filter_map { |i| i.name if i.missing == true }

        Wink::MqttClient.send_message(
          "#{c} item status: #{missing_items.count} missing and #{broken_items.count} broken"
        )
      end

      Wink::MqttClient.send_message("See https://c3voc.de/wink/dashboard#items for more details.")
    end
  end

  desc "listen for mqtt wink events"
  task listen_for_mqtt_events: :environment do
    Wink::MqttClient.listen
  end
end
