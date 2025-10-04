class AddUniquenessIndexToCheckListUsers < ActiveRecord::Migration[8.0]
  def change
    change_table :check_list_users do |t|
      t.index [:check_list_id, :user_id], unique: true
    end
  end
end
