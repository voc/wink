class EventCase < ActiveRecord::Base
  belongs_to :event
  belongs_to :case
  has_one :check_list
  belongs_to :transport, optional: true

  before_destroy :check_for_list_and_transport


  private

 # Don't remove EventCases when a transport or a
 # CheckList exists.
  def check_for_list_and_transport
    if self.check_list.nil? || self.transport.nil?
      return false
    end
  end
end
