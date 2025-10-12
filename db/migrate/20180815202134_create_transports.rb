# frozen_string_literal: true

class CreateTransports < ActiveRecord::Migration[5.2]
  def change
    create_table :transports do |t|
      t.text :source_address
      t.text :destination_address
      t.datetime :pickup_time
      t.datetime :delivery_time

      t.integer :pickup_timeframe
      t.integer :delivery_timeframe

      t.text :pickup_contact
      t.text :delivery_contact

      t.boolean :quotation, default: false
      t.boolean :ordered, default: false

      t.string :carrier

      t.integer :destination_event # event_id
      t.integer :source_event      # event_id
    end
  end
end
