# frozen_string_literal: true

class CaseType < ApplicationRecord
  has_many :cases, dependent: :restrict_with_error
end
