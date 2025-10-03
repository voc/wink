class CheckList < ActiveRecord::Base
  belongs_to :event_case
  has_one :event, through: :event_case
  has_one :case,  through: :event_case
  has_many :check_list_items, dependent: :destroy

  validates :advisor, presence: true

  after_create :copy_items!
  after_create :send_mqtt_message!

  def locations
    self.check_list_items.map do |cli|
      cli if cli.item&.shelf?
    end.compact
  end

  def items
    self.check_list_items
  end

  def items_without_shelfs
    self.check_list_items - self.locations
  end

  private

  def copy_items!
    event_case.case.items.not_deleted.each do |ec_item|
      cl_item = CheckListItem.new
      cl_item.item = ec_item
      cl_item.item.broken = ec_item.broken
      cl_item.item.missing = ec_item.missing
      self.check_list_items << cl_item
      self.save!
    end
  end

  def send_mqtt_message!
    Wink::MqttClient.send_message("'#{self.advisor}' created '#{self.event.name}' checklist for '#{self.case.name}'")
  end
end
