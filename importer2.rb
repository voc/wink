require 'csv'

def load_csv
  @cases = {}

  index = 0
  CSV.foreach('muCCC-Wink.csv', :headers => true, :col_sep => ';', :header_converters => :symbol) do |row|

    if @cases[row[:case]].nil?
      @cases[row[:case]] = []
    end
    puts row

    @cases[row[:case]] << row
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
        puts ' ignoring:'
        puts item
        next
      end

      i = Item.find_by(id: item[:id])

      if i.nil?
        i = Item.new(
          id: item[:id],
          name: item[:name],
          description: item[:description],
          manufacturer: item[:manufacturer],
          model: item[:model],
          date_of_purchase: item[:date_of_purchase],
          price: item[:price],
          serial_number: item[:seriennummer],
          item_type_id: item[:item_type_id],
          item_id: item[:parent_item_id],
          location_item_id: item[:location_item_id],
          case: c
        )
        i.save!
        puts " Item #{item['name']} was added successfully."
      else
        puts " Item #{i.name} already exists, updating..."
        i.update(
          name: item[:name],
          description: item[:description],
          manufacturer: item[:manufacturer],
          model: item[:model],
          date_of_purchase: item[:date_of_purchase],
          price: item[:price],
          serial_number: item[:seriennummer],
          item_type_id: item[:item_type_id],
          item_id: item[:parent_item_id],
          location_item_id: item[:location_item_id]
        )
        i.save!
      end
    end
  end
end

load_csv
import_items
