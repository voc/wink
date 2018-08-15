class CreateItemComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comment_item_associations do |t|
      t.belongs_to :event
      t.text :comment
      t.timestamps
    end
  end
end
