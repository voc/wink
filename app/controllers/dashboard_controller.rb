class DashboardController < ApplicationController

  def show
    @broken_items = Item.where(broken: true)
  end

end
