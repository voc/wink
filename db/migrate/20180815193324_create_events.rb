# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.datetime :buildup
      t.datetime :removel
      t.string :location

      t.timestamps
    end
  end
end
