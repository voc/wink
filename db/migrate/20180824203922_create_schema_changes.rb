# frozen_string_literal: true

class CreateSchemaChanges < ActiveRecord::Migration[5.2]
  def change
    change_table(:event_cases) do |t|
      t.belongs_to :check_list, index: true
    end

    remove_column :check_lists, :case_id
    remove_column :check_lists, :event_id
  end
end
