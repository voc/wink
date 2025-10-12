# frozen_string_literal: true

class CreateCheckListItems < ActiveRecord::Migration[5.2]
  def change
    create_table :check_list_items do |t|
      t.belongs_to :check_list
      t.belongs_to :item
      t.belongs_to :case

      t.boolean :broken
      t.boolean :missing
      t.text :comment

      t.timestamps
    end
  end
end
