# frozen_string_literal: true

class CreateItemTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :item_types do |t|
      t.string :name

      t.timestamps
    end

    change_table(:items) do |t|
      t.belongs_to :item_type, index: true
    end
  end
end
