class AddForeignKeys < ActiveRecord::Migration[8.0]
  def change
    # cases → case_types
    add_foreign_key :cases, :case_types

    # check_list_items → check_lists, items, cases
    add_foreign_key :check_list_items, :check_lists
    add_foreign_key :check_list_items, :items
    add_foreign_key :check_list_items, :cases

    # event_cases → events, cases, transports, check_lists
    EventCase.all.each do |ec|
      ec.destroy! if ec.event.nil? or ec.case.nil?
    end
    add_foreign_key :event_cases, :events
    add_foreign_key :event_cases, :cases
    add_foreign_key :event_cases, :transports
    add_foreign_key :event_cases, :check_lists

    # items → cases, item_types
    add_foreign_key :items, :cases
    add_foreign_key :items, :item_types

    # items self-references
    add_foreign_key :items, :items, column: :item_id

    # items.location_item_id must be bigint to reference items.id
    change_column :items, :location_item_id, :bigint
    add_index :items, :location_item_id unless index_exists?(:items, :location_item_id)
    add_foreign_key :items, :items, column: :location_item_id

    # item_comments → items (users fk already present)
    add_foreign_key :item_comments, :items

    # transports → events (destination/source)
    change_column :transports, :destination_event_id, :bigint
    change_column :transports, :source_event_id, :bigint
    add_index :transports, :destination_event_id unless index_exists?(:transports, :destination_event_id)
    add_index :transports, :source_event_id unless index_exists?(:transports, :source_event_id)
    add_foreign_key :transports, :events, column: :destination_event_id
    add_foreign_key :transports, :events, column: :source_event_id
  end
end
