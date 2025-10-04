# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Case types
["Room case", "Audio case"].each do |type|
  CaseType.find_or_create_by(name: type)
end

# Cases
[1,2,3,4,5,6].each do |number|
  Case
    .find_or_create_by(name: "Case #{number}")
    .update(
      acronym: "S#{number}",
      case_type: CaseType.find_by(name: "Room case"),
    )

  Case
    .find_or_create_by(name: "Audio case #{number}")
    .update(
      acronym: "A#{number}",
      case_type: CaseType.find_by(name: "Audio case")
    )
end

# Events
Event
  .find_or_create_by(name: "FrOSCon 2018")
  .update(
    location: "St. Augustin",
    start_date: Date.parse("2018-08-25"),
    end_date: Date.parse("2018-08-26"),
    buildup: DateTime.parse("2018-08-24 10:00"),
    removel: DateTime.parse("2018-08-26 18:00"),
    case_ids: [1,5,6]
  )

# Item types
["Netzteil", "Kabel", "Adapter", "Device", "Meshbag", "Fach"].each do |type|
  ItemType.find_or_create_by(name: type)
end

# Items
Item
  .find_or_create_by(name: "Fach vorne links")
  .update(
    case: Case.first,
    item_type: ItemType.find_by(name: "Fach")
  )

Item
  .find_or_create_by(name: "Fach hinten rechts")
  .update(
    case: Case.first,
    item_type: ItemType.find_by(name: "Fach")
  )

Item
  .find_or_create_by(name: "Meshbag Speaker-Adapter")
  .update(
    case: Case.first,
    item_type: ItemType.find_by(name: "Meshbag"),
    location: Item.find_by(name: "Fach vorne links")
  )

Item
  .find_or_create_by(name: "Encoding Cube", case: Case.first)
  .update(
    price: 1000,
    date_of_purchase: Date.parse("2014-05-01"),
    serial_number: "02656001-d69e-4d23-8d0f-1a36b7b1dd71"
  )

Item
  .find_or_create_by(name: "Encoding Cube", case: Case.find(3))
  .update(
    price: 1000,
    date_of_purchase: Date.parse("2014-05-01"),
    serial_number: "54348a31-e4da-4930-b36b-411c2f25655a",
    broken: true
  )

Item
  .find_or_create_by(name: "TouchMix", case: Case.find(2))
  .update(
    manufacturer: "QSC",
    model: "TouchMix-16",
    price: 666,
    date_of_purchase: Date.parse("2017-05-23"),
    serial_number: "3be4f2e4-494d-4f2f-918d-f880f51af0c6",
    broken: false
  )

Item
  .find_or_create_by(name: "Mixer Notebook", case: Case.first)
  .update(
    manufacturer: "Lenovo",
    model: "T420 L",
    price: 800,
    date_of_purchase: Date.parse("2014-05-01"),
    serial_number: "7d9dc4bf-d9c6-4818-8ebd-138428b27a62",
    location: Item.find_by(name: "Notebook-Fach")
  )

Item
  .find_or_create_by(name: "Netzteil Mixer Notebook", case: Case.first)
  .update(
    item_type: ItemType.find_by(name: "Netzteil"),
    item: Item.find_by(case: Case.first, name: "Mixer Notebook"),
    location: Item.find_by(name: "Fach hinten rechts")
  )

Item
  .find_or_create_by(name: "VGA → HDMI-Adapter", case: Case.first)
  .update(
    item_type: ItemType.find_by(name: "Adapter"),
    location: Item.find_by(name: "Meshbag Speaker-Adapter")
  )

Item
  .find_or_create_by(name: "DisplayPort → HDMI-Adapter", case: Case.first, missing: true, deleted: false)
  .update(
    item_type: ItemType.find_by(name: "Adapter"),
    location: Item.find_by(name: "Meshbag Speaker-Adapter")
  )

Item
  .find_or_create_by(name: "DisplayPort → HDMI-Adapter", case: Case.first, missing: true, deleted: true)
  .update(
    item_type: ItemType.find_by(name: "Adapter"),
    location: Item.find_by(name: "Meshbag Speaker-Adapter")
  )

Item
  .find_or_create_by(name: "USBC → HDMI-Adapter", case: Case.first, broken: true, deleted: false)
  .update(
    item_type: ItemType.find_by(name: "Adapter"),
    location: Item.find_by(name: "Meshbag Speaker-Adapter")
  )

Item
  .find_or_create_by(name: "USBC → HDMI-Adapter", case: Case.first, broken: true, deleted: true)
  .update(
    item_type: ItemType.find_by(name: "Adapter"),
    location: Item.find_by(name: "Meshbag Speaker-Adapter")
  )

# Item comments
ItemComment.find_or_create_by(
  author: "meise",
  comment: "defekt",
  item_id: Item.last.id
)

ItemComment.find_or_create_by(
  author: "Peter Lustig",
  comment: "wieder ganz",
  item_id: Item.last.id
)
# Transports


# Checklists
event_case = EventCase.first
if not event_case.check_list
  event_case.create_check_list!(advisor: 'Peter Lustig', comment: 'foobar, möp möp 23')
end
