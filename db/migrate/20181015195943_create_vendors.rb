class CreateVendors < ActiveRecord::Migration[5.2]
  def change
    create_table :vendors do |t|
      t.string  :name
      t.string  :account_name
      t.string  :customer_id
      t.boolean :on_account

      t.timestamps
    end
  end
end
