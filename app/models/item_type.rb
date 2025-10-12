# frozen_string_literal: true

class ItemType < ApplicationRecord
  has_many :items, dependent: :restrict_with_error

  validates :name, uniqueness: true, presence: true

  LOCATIONS = %w[Fach Meshbag].freeze
end
