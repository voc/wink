# frozen_string_literal: true

class ItemType < ApplicationRecord
  SECTIONS = %w[Fach].freeze
  BAGS = %w[Meshbag].freeze
  LOCATIONS = (SECTIONS + BAGS).freeze

  RELATABLE_ITEMS = %w[Device].freeze
  SPECIAL_TYPES = (LOCATIONS + RELATABLE_ITEMS).freeze

  has_many :items, dependent: :restrict_with_error

  validates :name, uniqueness: true, presence: true

  def self.locations
    ItemType.where(name: LOCATIONS)
  end

  def self.sections
    ItemType.where(name: SECTIONS)
  end

  def self.relatable_items
    ItemType.where(name: RELATABLE_ITEMS)
  end
end
