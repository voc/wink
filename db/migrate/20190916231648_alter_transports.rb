# frozen_string_literal: true

class AlterTransports < ActiveRecord::Migration[5.2]
  def change
    rename_column :transports, :source_event, :source_event_id
    rename_column :transports, :destination_event, :destination_event_id

    change_table(:transports) do |t|
      t.string :tracking_number
      t.integer :shipment_id
      t.string :delivery_state
      t.datetime :actual_pickup_time
      t.datetime :actual_delivery_time
    end
  end
end
