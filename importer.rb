# frozen_string_literal: true

require 'pathname'
# rubocop:disable Layout/LineLength
#     0        1            2             3             4         5              6                7   8 9       10     11     12            13     14
# Hersteller,Modell,Gerätebeschreibung,Seriennummer,Eigentümer,Eigentümer,Wiederbeschaffungswert,Case,,Class ,Kommentar,,Anschaffungsjahr,Händler,Rechnung
# rubocop:enable Layout/LineLength

def load_csv
  @cases = {}

  index = 0
  File.open(Pathname("seriennummern.csv")).each_line do |line|
    index += 1
    next if index == 1

    object = line.split(",")
    @cases[object[7]] = [] if @cases[object[7]].nil?

    item = {
      name: object[2],
      hersteller: object[0],
      model: object[1],
      beschreibung: object[2],
      seriennummer: object[3],
      price: object[6],
      case: object[7]
    }

    @cases[object[7]] << item
  end
end

def import_items
  @cases.each_key do |key|
    c = Case.find_by(acronym: key)

    if c.nil?
      puts "'#{key}' not found."
      next
    else
      puts "Case: #{key}"
    end

    @cases[key].each do |item|
      next if item[:name].empty?

      i = Item.new(
        name: item[:name],
        model: item[:model],
        manufacturer: item[:hersteller],
        description: item[:beschreibung],
        serial_number: item[:seriennummer],
        price: item[:price].delete('€').to_f,
        case: c
      )

      i.save!
    end
  end
end

load_csv
import_items
