# frozen_string_literal: true

class Case < ApplicationRecord
  belongs_to :case_type
  belongs_to :event_case, optional: true

  has_many :event_cases, dependent: :restrict_with_error
  has_many :events, through: :event_cases
  has_many :check_lists, through: :event_cases

  has_many :items, dependent: :destroy

  validates :name, presence: true
  validates :acronym, presence: true

  def locations
    not_deleted_items.where(item_type: ItemType.locations)
  end

  def sections
    not_deleted_items.where(item_type: ItemType.sections)
  end

  def relatable_items
    not_deleted_items.where(item_type: ItemType.relatable_items)
  end

  def active_items
    not_deleted_items.where.not(item_type: ItemType.locations)
  end

  def not_deleted_items
    Item.existing.where(case: self)
  end

  def flagged_items
    not_deleted_items.where("( broken = true OR missing = true )")
  end

  def check_list_exists?(event)
    !check_list(event).nil?
  end

  def check_list(event)
    ec = EventCase.find_by(event: event, case: self)

    if ec.nil? || ec.check_list.nil?
      nil
    else
      ec.check_list
    end
  end
end
