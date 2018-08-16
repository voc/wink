class CreateEventCases < ActiveRecord::Migration[5.2]
  def change
    create_table :event_cases do |t|
      t.belongs_to :event
      t.belongs_to :case
      t.belongs_to :transport

      t.timestamps
    end
  end
end
