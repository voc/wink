class CreateCheckLists < ActiveRecord::Migration[5.2]
  def change
    create_table :check_lists do |t|
      t.belongs_to :case
      t.belongs_to :event
      
      t.text :comment
      t.string :advisor

      t.timestamps
    end
  end
end
