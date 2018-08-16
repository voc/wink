class ItemsController < ApplicationController

  before_action :find_item, except: [:index, :create, :new]

  def show
  end

  def index
    @items = Item.all
  end

  private

  def find_item
    @item = Item.find(params[:id])
  end

end
