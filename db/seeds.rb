# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

["Room case", "Audio case"].each do |type|
  CaseType.create(name: type)
end

[1,2,3,4,5,6].each do |number|
  Case.create(name: "Case #{number}", number: number,
    case_type: CaseType.find_by(name: "Room case"))

  Case.create(name: "Audio case #{number}", number: number,
    case_type: CaseType.find_by(name: "Audio case"))
end
