class AddUserToComment < ActiveRecord::Migration[8.0]
  def change
    add_reference :item_comments, :users, null: true, foreign_key: true
  end
end
