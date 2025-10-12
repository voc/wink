# frozen_string_literal: true

class CreateCases < ActiveRecord::Migration[5.2]
  def change
    create_table :cases do |t|
      t.belongs_to :case_type, index: true

      t.string :name
      t.string :acronym

      t.timestamps
    end
  end
end
