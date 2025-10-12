# frozen_string_literal: true

class Event < ApplicationRecord
  has_many :event_cases
  has_many :cases, through: :event_cases
  has_many :check_lists, through: :event_cases

  validates :name, uniqueness: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :location, presence: true

  def transports
    Transport.where("destination_event_id = #{id} or source_event_id = #{id}")
  end
end
