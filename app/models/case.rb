class Case < ActiveRecord::Base
  belongs_to :case_type
  belongs_to :event_case, optional: true

  has_many :event_cases
  has_many :events,      through: :event_cases
  has_many :check_lists, through: :event_cases

  has_many :items

  validates :name, presence: true
  validates :acronym, presence: true
  validates :case_type, presence: true


  def locations
    Item.where("case_id = #{self.id} AND \
      deleted = false AND
      (item_type_id = #{ItemType.find_by(name: "Meshbag").id} or
      item_type_id = #{ItemType.find_by(name: "Fach").id})")
  end

  def sections
    Item.where("case_id = #{self.id} AND \
      deleted = false AND
      item_type_id = #{ItemType.find_by(name: "Fach").id}")
  end

  def relateable_items
    Item.where("case_id = #{self.id} AND \
      deleted = false AND
      item_type_id IN(
        #{ItemType.find_by(name: "Device").id}
      )")
  end

  def active_items
    Item.where("case_id = #{self.id} AND \
      deleted = false AND
      item_type_id NOT IN(
        #{ItemType.find_by(name: "Meshbag").id}, 
        #{ItemType.find_by(name: "Fach").id}
      )")
  end

  def not_deleted_items
    Item.where("case_id = #{self.id} AND deleted = false")
  end

  def flagged_items
    Item.where("case_id = #{self.id} AND 
      deleted = false AND ( broken = true OR missing = true )")
  end

  def check_list_exists?(event)
    if check_list(event).nil?
      false
    else
      true
    end
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
