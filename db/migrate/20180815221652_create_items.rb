# frozen_string_literal: true

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
      t.boolean :broken, default: false
      t.boolean :missing, default: false

      t.timestamps
    end
  end
end
