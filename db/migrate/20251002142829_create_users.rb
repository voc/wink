class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :email
      t.string :name

      t.timestamps
    end
    add_index :users, :uid
  end
end
