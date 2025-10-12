# frozen_string_literal: true

class AddLocationToItems < ActiveRecord::Migration[5.2]
  change_table(:items) do |t|
    t.integer :location_item_id, index: true
  end
end
