# frozen_string_literal: true

class MakeBooleanColumnsNonNull < ActiveRecord::Migration[8.0]
  def change
    change_column_default :check_list_items, :broken, false
    CheckListItem.where(broken: nil).update_all(broken: false)
    change_column_null :check_list_items, :broken, false
    change_column_default :check_list_items, :missing, false
    CheckListItem.where(missing: nil).update_all(missing: false)
    change_column_null :check_list_items, :missing, false
    change_column_default :check_list_items, :checked, false
    CheckListItem.where(checked: nil).update_all(checked: false)
    change_column_null :check_list_items, :checked, false

    change_column_null :check_lists, :checked, false
    CheckList.where(checked: nil).update_all(checked: false)
    change_column_default :check_lists, :checked, false

    Item.where(broken: nil).update_all(broken: false)
    change_column_null :items, :broken, false
    Item.where(missing: nil).update_all(missing: false)
    change_column_null :items, :missing, false
    Item.where(deleted: nil).update_all(deleted: false)
    change_column_null :items, :deleted, false

    Transport.where(quotation: nil).update_all(quotation: false)
    change_column_null :transports, :quotation, false
    Transport.where(ordered: nil).update_all(ordered: false)
    change_column_null :transports, :ordered, false
  end
end
