class Event < ActiveRecord::Base
  has_many :event_cases
  has_many :cases, through: :event_cases

  validates :name, uniqueness: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :location, presence: true

  def transports
    Transport.where("destination_event = #{self.id} or source_event = #{id}")
  end
end
