# frozen_string_literal: true

class AddMissingUniqueIndexes < ActiveRecord::Migration[8.0]
  def change
    add_index :events, :name, unique: true
    add_index :item_types, :name, unique: true
  end
end
