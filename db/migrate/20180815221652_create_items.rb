class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.string :manufacturer
      t.string :model
      t.belongs_to :item, index: true
      t.belongs_to :case, index: true
      t.date :date_of_purchase
      t.decimal :price
      t.string :serial_number

      t.timestamps
    end
  end
end
