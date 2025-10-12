# frozen_string_literal: true

class AddCheckedToCheckLists < ActiveRecord::Migration[5.2]
  def change
    change_table(:check_lists) do |t|
      t.boolean :checked
    end
  end
end
