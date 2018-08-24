class ItemTypesController < ApplicationController

  before_action :find_item_type, except: [:index, :create, :new]

  def show
  end

  def index
    @item_types = ItemType.all
  end


  def new
    @item_type = ItemType.new()
  end

  def create
    @item_type = ItemType.new(item_params)

    if @item_type.save
      redirect_to item_type_path(@item_type)
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @item_type.update_attributes(item_params)
      redirect_to case_path(@item_type.case)
    else
      render action: 'edit'
    end
  end

  def delete
  end

  def destroy
    @item_type.destroy
    redirect_to items_path
  end

  private

  def find_item_type
    @item_type = ItemType.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name)
  end

end
