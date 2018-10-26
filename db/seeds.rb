# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Case types
["Room case", "Audio case"].each do |type|
  CaseType.create(name: type)
end

# Cases
[1,2,3,4,5,6].each do |number|
  Case.create(name: "Case #{number}", acronym: "S#{number}",
    case_type: CaseType.find_by(name: "Room case"))

  Case.create(name: "Audio case #{number}", acronym: "A#{number}",
    case_type: CaseType.find_by(name: "Audio case"))
end

# Events
Event.create(
  name: "FrOSCon 2018",
  location: "St. Augustin",
  start_date: Date.parse("2018-08-25"),
  end_date: Date.parse("2018-08-26"),
  buildup: DateTime.parse("2018-08-24 10:00"),
  removel: DateTime.parse("2018-08-26 18:00"),
  case_ids: [1,5,6]
)


["Netzteil", "Kabel", "Adapter", "Device", "Meshbag", "Fach"].each do |type|
  ItemType.create(
    name: type
  )
end

# Items
Item.create(
  name: "Fach vorne links",
  case: Case.first,
  item_type: ItemType.find_by(name: "Fach")
)

Item.create(
  name: "Fach hinten rechts",
  case: Case.first,
  item_type: ItemType.find_by(name: "Fach")
)

Item.create(
  name: "Meshbag Speaker-Adapter",
  case: Case.first,
  item_type: ItemType.find_by(name: "Meshbag"),
  location: Item.find_by(name: "Fach vorne links")
)

Item.create(
  name: "Encoding Cube",
  case: Case.first,
  price: 1000,
  date_of_purchase: Date.parse("2014-05-01"),
  serial_number: "02656001-d69e-4d23-8d0f-1a36b7b1dd71"
)

Item.create(
  name: "Encoding Cube",
  case: Case.find(3),
  price: 1000,
  date_of_purchase: Date.parse("2014-05-01"),
  serial_number: "54348a31-e4da-4930-b36b-411c2f25655a",
  broken: true
)

Item.create(
  name: "TouchMix",
  manufacturer: "QSC",
  model: "TouchMix-16",
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
  location: Item.find_by(name: "Notebook-Fach")
)

Item.create(
  name: "Netzteil Mixer Notebook",
  case: Case.first,
  item_type: ItemType.find_by(name: "Netzteil"),
  item: Item.find_by(case: Case.first, name: "Mixer Notebook"),
  location: Item.find_by(name: "Fach hinten rechts")
)

Item.create(
  name: "VGA → HDMI-Adapter",
  case: Case.first,
  item_type: ItemType.find_by(name: "Adapter"),
  location: Item.find_by(name: "Meshbag Speaker-Adapter")
)

Item.create(
  name: "DisplayPort → HDMI-Adapter",
  case: Case.first,
  missing: true,
  item_type: ItemType.find_by(name: "Adapter"),
  location: Item.find_by(name: "Meshbag Speaker-Adapter")
)

Item.create(
  name: "DisplayPort → HDMI-Adapter",
  case: Case.first,
  missing: true,
  item_type: ItemType.find_by(name: "Adapter"),
  location: Item.find_by(name: "Meshbag Speaker-Adapter"),
  deleted: true
)

Item.create(
  name: "USBC → HDMI-Adapter",
  case: Case.first,
  broken: true,
  item_type: ItemType.find_by(name: "Adapter"),
  location: Item.find_by(name: "Meshbag Speaker-Adapter")
)

Item.create(
  name: "USBC → HDMI-Adapter",
  case: Case.first,
  broken: true,
  item_type: ItemType.find_by(name: "Adapter"),
  location: Item.find_by(name: "Meshbag Speaker-Adapter"),
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

# Checklists
event_case = EventCase.first
event_case.check_list = CheckList.new(advisor: 'Peter Lustig', comment: 'foobar, möp möp 23')
event_case.save

# Products
Product.create(
  name: "T420",
  description: "Lenovo Notebook, sehr gutes Teil!",
  product_number: "1337-23-42",
  product_link: "example.com/t420"
)

Vendor.create(
  name: "amazon",
  account_name: "voc@c3voc.de",
  on_account: false
)

Vendor.create(
  name: "reichelt elektronik GmbH & Co. KG",
  account_name: "foobar account",
  on_account: true
)

ProductVendorLink.create(
  product: Product.find_by(name: "T420"),
  vendor: Vendor.find_by(name: "amazon"),
  order_number: "4223",
  order_link: "https://xitra24.de/eshop.php?action=article_detail&rid=gh&s_supplier_aid=5372893"
)

ProductVendorLink.create(
  product: Product.find_by(name: "T420"),
  vendor: Vendor.find_by(name: "reichelt elektronik GmbH & Co. KG"),
  order_number: "42-1337-42",
  order_link: "https://www.reichelt.com/de/en/c-k-power-paint-mixer-420mm-ck-t1881-p168807.html?&trstct=pos_0"
)

item = Item.find_by(name: "Mixer Notebook")
item.product = Product.find_by(name: "T420")
item.save
