# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

ItemType::SPECIAL_TYPES.each do |location|
  ItemType.create(name: location)
end

return unless Rails.env.local?

# Set types
[ "Lecture room set", "Regie set", "other"].each do |type|
  CaseType.create_or_find_by(name: type)
end

## Sets
# We called 'sets' initally, 'cases' but now each set consits of multiple flight cases, 
# This is a bit confusing but we can not change it now without breaking existing code and tests.
[ 1, 2, 3, 4, 5, 6 ].each do |number|
  Case.create(name: "Room #{number}", acronym: "S#{number}",
              case_type: CaseType.find_by(name: "Lecture room set"))
end

# Events
Event.create(
  name: "FrOSCon 2018",
  location: "St. Augustin",
  start_date: Date.parse("2018-08-25"),
  end_date: Date.parse("2018-08-26"),
  buildup: DateTime.parse("2018-08-24 10:00"),
  removel: DateTime.parse("2018-08-26 18:00"),
  case_ids: [ 1, 5, 6 ]
)

["Case", "Compartment", "Box", "Device", "Power supply", "Cable", "Adapter"].each do |type|
  ItemType.create_or_find_by(
    name: type
  )
end

# Flight Cases
Item.create(
  name: "Case 1.1",
  case: Case.first,
  item_type: ItemType.find_by(name: "Case")
)

Item.create(
  name: "Case 1.2",
  case: Case.first,
  item_type: ItemType.find_by(name: "Case")
)

case1_1 = Item.find_by(name: "Case 1.1")
case1_2 = Item.find_by(name: "Case 1.2")

# Items
Item.create(
  name: "Compartment Audio",
  case: Case.first,
  item_type: ItemType.find_by(name: "Compartment"),
  location: case1_1
)

Item.create(
  name: "Compartment Video",
  case: Case.first,
  item_type: ItemType.find_by(name: "Compartment"),
  location: case1_2
)

Item.create(
  name: "Box Mixer Laptop",
  case: Case.first,
  item_type: ItemType.find_by(name: "Box")
)

Item.create(
  name: "Box Speaker Adapters",
  case: Case.first,
  item_type: ItemType.find_by(name: "Meshbag")
)

Item.create(
  name: "Box Speaker Adapters",
  case: Case.first,
  item_type: ItemType.find_by(name: "Box"),
  location: Item.find_by(name: "Compartment Audio")
)

Item.create(
  name: "Module Encoder",
  case: Case.first,
  price: 1000,
  date_of_purchase: Date.parse("2014-05-01"),
  serial_number: "02656001-d69e-4d23-8d0f-1a36b7b1dd71"
)

Item.create(
  name: "Module Encoder",
  case: Case.find(3),
  price: 1000,
  date_of_purchase: Date.parse("2014-05-01"),
  serial_number: "54348a31-e4da-4930-b36b-411c2f25655a",
  broken: true
)

Item.create(
  name: "Audio Mixer",
  manufacturer: "Allen&Heath",
  model: "CQ18T",
  case: Case.find(2),
  price: 666,
  date_of_purchase: Date.parse("2017-05-23"),
  serial_number: "3be4f2e4-494d-4f2f-918d-f880f51af0c6",
  broken: false
)

Item.create(
  name: "Mixer Notebook",
  manufacturer: "Lenovo",
  model: "T420 L",
  case: Case.first,
  price: 800,
  date_of_purchase: Date.parse("2014-05-01"),
  serial_number: "7d9dc4bf-d9c6-4818-8ebd-138428b27a62",
  location: Item.find_by(name: "Box Mixer Laptop")
)

Item.create(
  name: "Netzteil Mixer Notebook",
  case: Case.first,
  item_type: ItemType.find_by(name: "Netzteil"),
  item: Item.find_by(case: Case.first, name: "Mixer Notebook"),
  location: Item.find_by(name: "Box Mixer Laptop")
)

Item.create(
  name: "VGA → HDMI-Adapter",
  case: Case.first,
  item_type: ItemType.find_by(name: "Adapter"),
  location: Item.find_by(name: "Box Speaker Adapters")
)

Item.create(
  name: "DisplayPort → HDMI-Adapter",
  case: Case.first,
  missing: true,
  item_type: ItemType.find_by(name: "Adapter"),
  location: Item.find_by(name: "Box Speaker Adapters")
)

Item.create(
  name: "DisplayPort → HDMI-Adapter",
  case: Case.first,
  missing: true,
  item_type: ItemType.find_by(name: "Adapter"),
  location: Item.find_by(name: "Box Speaker Adapters"),
  deleted: true
)

Item.create(
  name: "USBC → HDMI-Adapter",
  case: Case.first,
  broken: true,
  item_type: ItemType.find_by(name: "Adapter"),
  location: Item.find_by(name: "Box Speaker Adapters")
)

Item.create(
  name: "USBC → HDMI-Adapter",
  case: Case.first,
  broken: true,
  item_type: ItemType.find_by(name: "Adapter"),
  location: Item.find_by(name: "Box Speaker Adapters"),
  deleted: true
)

# Item comments
ItemComment.create(
  author: "meise",
  comment: "defekt",
  item_id: Item.last.id
)

ItemComment.create(
  author: "Peter Lustig",
  comment: "wieder ganz",
  item_id: Item.last.id
)
