class DashboardController < ApplicationController

  def show
    @broken_or_missing_items = Item.where("broken = true or missing = true")
  end

end
