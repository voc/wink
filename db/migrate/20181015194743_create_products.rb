class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.string :product_number
      t.string :product_link

      t.timestamps
    end
  end
end
