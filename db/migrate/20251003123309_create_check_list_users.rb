class CreateCheckListUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :check_list_users do |t|
      t.references :check_list, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
    end
  end
end
