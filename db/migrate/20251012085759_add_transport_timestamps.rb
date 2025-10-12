# frozen_string_literal: true

class AddTransportTimestamps < ActiveRecord::Migration[8.0]
  def change
    add_timestamps :transports, default: -> { "CURRENT_TIMESTAMP" }
  end
end
