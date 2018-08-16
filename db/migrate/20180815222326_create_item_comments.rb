class CreateItemComments < ActiveRecord::Migration[5.2]
  def change
    create_table :item_comments do |t|
      t.belongs_to :item
      t.text :comment
      t.string :author

      t.timestamps
    end
  end
end
