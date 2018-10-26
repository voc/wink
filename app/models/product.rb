class Product < ActiveRecord::Base
  has_many :vendor_links, :class_name => "ProductVendorLink", :foreign_key => "product_id"
  has_many :items

end
