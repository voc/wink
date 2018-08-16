class DashboardController < ApplicationController

  def show
    @broken_or_missing_items = Item.where("broken = true or missing = true")
    @upcoming_events = Event.where(start_date: Date.today..2.month.after)
  end

end
