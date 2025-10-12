# frozen_string_literal: true

class EventCase < ApplicationRecord
  belongs_to :event
  belongs_to :case
  belongs_to :check_list, optional: true
  belongs_to :transport, optional: true

  before_destroy :check_for_list_and_transport

  private

  # Don't remove EventCases when a transport or a
  # CheckList exists.
  def check_for_list_and_transport
    return unless check_list.nil? || transport.nil?

      false
  end
end
