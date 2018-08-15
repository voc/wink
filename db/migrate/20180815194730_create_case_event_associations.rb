class CreateCaseEventAssociations < ActiveRecord::Migration[5.2]
  def change
    create_table :case_event_associations do |t|
      t.belongs_to :event
      t.belongs_to :case
      t.timestamps
    end
  end
end
