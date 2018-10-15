class CreateProductVendorLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :product_vendor_links do |t|
      t.belongs_to :product
      t.belongs_to :vendor
      t.string :order_link
      t.string :order_number

      t.timestamps
    end
  end
end
