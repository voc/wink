class DashboardController < ApplicationController

  def show
    @broken_or_missing_items = Item.where(broken: true).where(deleted: false) + Item.where(missing: true).where(deleted: false)
    @upcoming_events = Event.
      where(end_date: Date.today-2..4.weeks.after).order(:start_date)
    @upcoming_transports = Transport.
      where(pickup_time: Date.today..4.weeks.after).order(:pickup_time)
  end
end
