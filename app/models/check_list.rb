# frozen_string_literal: true

class CheckList < ApplicationRecord
  has_one :event_case
  has_one :event, through: :event_case
  has_one :case,  through: :event_case

  has_many :check_list_items

  validates :advisor, presence: true

  # rubocop:disable Naming/PredicateMethod
  def copy_items!
    return false if check_list_items.any?

    event_case.case.not_deleted_items.each do |ec_item|
      cl_item = CheckListItem.new
      cl_item.item = ec_item
      cl_item.item.broken = ec_item.broken
      cl_item.item.missing = ec_item.missing
      check_list_items << cl_item
      save!
    end

    true
  end
  # rubocop:enable Naming/PredicateMethod

  def locations
    check_list_items.select { |cli| cli.item&.shelf? }
  end

  def items
    check_list_items
  end

  def items_without_shelfs
    check_list_items - locations
  end
end
