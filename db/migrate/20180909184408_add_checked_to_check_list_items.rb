class AddCheckedToCheckListItems < ActiveRecord::Migration[5.2]
  def change
    change_table(:check_list_items) do |t|
      t.boolean :checked
    end
  end
end
