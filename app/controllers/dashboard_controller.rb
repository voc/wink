# frozen_string_literal: true

class DashboardController < ApplicationController
  def show
    @broken_or_missing_items = Item
                               .where(deleted: false)
                               .and(
                                 Item.where(broken: true)
                                     .or(Item.where(missing: true))
                               ).sort
    @grouped_items = @broken_or_missing_items.sort_by(&:case_id).group_by(&:case)
    @upcoming_events = Event
                       .where(end_date: (Time.zone.today - 2)..4.weeks.after).order(:start_date)
    @upcoming_transports = Transport
                           .where(pickup_time: Time.zone.today..4.weeks.after).order(:pickup_time)
  end
end
