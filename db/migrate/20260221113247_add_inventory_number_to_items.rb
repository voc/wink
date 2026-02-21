# frozen_string_literal: true

class AddInventoryNumberToItems < ActiveRecord::Migration[8.1]
  def change
    add_column :items, :inventory_number, :string, null: true
    add_index :items, :inventory_number, unique: true
  end
end
