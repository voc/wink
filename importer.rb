require 'pathname'
#     0        1            2             3             4         5              6                7   8 9       10     11     12            13     14
# Hersteller,Modell,Gerätebeschreibung,Seriennummer,Eigentümer,Eigentümer,Wiederbeschaffungswert,Case,,Class ,Kommentar,,Anschaffungsjahr,Händler,Rechnung

def load_csv
  @cases = {}

  index = 0
  File.open(Pathname("seriennummern.csv")).each_line do |line|
    index += 1
    if index == 1
      next
    end

    object = line.split(/,/)
    if @cases[object[7]].nil?
      @cases[object[7]] = []
    end

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
  @cases.keys.each do |key|
    c = Case.find_by(acronym: key)

    if c.nil?
      puts "'#{key}' not found."
      next
    else
      puts "Case: #{key}"
    end

    @cases[key].each do |item|
      if item[:name].empty?
        next
      end

      i = Item.new(
        name: item[:name],
        model: item[:model],
        manufacturer: item[:hersteller],
        description: item[:beschreibung],
        serial_number: item[:seriennummer],
        price: item[:price].gsub('€', '').to_f,
        case: c
      )

      i.save!
    end
  end
end

load_csv
import_items
