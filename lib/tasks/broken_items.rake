namespace :wink do
  desc "send broken/missing items to mqtt server"
  task send_broken_missing_items: :environment do
    items = Item.all.where('deleted = false and (broken = true or missing = true)')
    grouped_items = items.group_by{ |i| i.case.name }

    if items.count > 0
      grouped_items.each_key do |c|
        broken_items  = grouped_items[c].map{|i| i.name if i.broken == true}.compact
        missing_items = grouped_items[c].map{|i| i.name if i.missing == true}.compact

        Wink::MqttClient.send_message("#{c} item status: #{missing_items.count} missing and #{broken_items.count} broken")
      end
      
      Wink::MqttClient.send_message("See https://c3voc.de/wink/dashboard#items for more details.")
    end
  end
end
