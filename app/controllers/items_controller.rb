class ItemsController < ApplicationController

  before_action :find_item, except: [:index, :create, :new]

  def show
  end

  def index
    @items = Item.all
  end


    def new
      @item = Item.new(case: Case.find(params[:case_id]))
    end

    def create
      @item = Item.new(item_params)

      if @item.save
        redirect_to items_path
      else
        render action: 'new'
      end
    end

    def edit
    end

    def update
      if @item.update_attributes(item_params)
        redirect_to items_path
      else
        render action: 'edit'
      end
    end

    def delete
    end

    def destroy
      @item.destroy
      redirect_to items_path
    end

  private

  def find_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :manufactor, :model,
                                 :item_id, :case_id, :date_of_purchase,
                                 :price, :serial_number, :broken, :missing)
  end

end
