# frozen_string_literal: true

class AddDeletedToItems < ActiveRecord::Migration[5.2]
  def change
    change_table(:items) do |t|
      t.boolean :deleted, default: false
    end
  end
end
