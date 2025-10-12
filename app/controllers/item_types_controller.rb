# frozen_string_literal: true

class ItemTypesController < ApplicationController
  before_action :find_item_type, except: %i[index create new]

  def index
    @item_types = ItemType.all
  end

  def show; end

  def new
    @item_type = ItemType.new
  end

  def edit; end

  def create
    @item_type = ItemType.new(item_params)

    if @item_type.save
      redirect_to item_type_path(@item_type)
    else
      render action: "new"
    end
  end

  def update
    if @item_type.update(item_params)
      redirect_to case_path(@item_type.case)
    else
      render action: "edit"
    end
  end

  def delete; end

  def destroy
    @item_type.destroy
    redirect_to items_path
  end

  private

  def find_item_type
    @item_type = ItemType.find(params[:id])
  end

  def item_params
    params.expect(item: [ :name ])
  end
end
