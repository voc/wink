class CreateCaseTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :case_types do |t|
      t.string :name
    end
  end
end
