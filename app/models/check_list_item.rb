# frozen_string_literal: true

class CheckListItem < ApplicationRecord
  belongs_to :check_list
  belongs_to :item
end
