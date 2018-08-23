class DashboardController < ApplicationController

  def show
    @broken_or_missing_items = Item.where(broken: true) + Item.where(missing: true)
    @upcoming_events = Event.
      where(start_date: Date.today..4.weeks.after).order(:start_date)
    @upcoming_transports = Transport.
      where(pickup_time: Date.today..4.weeks.after).order(:pickup_time)
  end
end
