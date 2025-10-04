class MoveCheckListFkToCheckLists < ActiveRecord::Migration[8.0]
  def change
    add_reference :check_lists, :event_case, foreign_key: true, null: true

    # migrate existing foreign keys
    execute <<~SQL
      UPDATE check_lists
      SET event_case_id = event_cases.id
      FROM event_cases
      WHERE event_cases.check_list_id = check_lists.id
        AND check_lists.event_case_id IS NULL
    SQL

    change_column_null :check_lists, :event_case_id, false
    remove_foreign_key :event_cases, :check_lists
    remove_reference :event_cases, :check_list, foreign_key: false
    change_reference :check_lists, :event_case, null: false
  end
end
