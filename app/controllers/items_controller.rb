require 'csv'

class ItemsController < ApplicationController

  before_action :find_item, except: [:index, :create, :new, :export]

  def show
    @subitems = Item.where(item: @item)
  end

  def index
    if params["commit"] == "Export"
      redirect_to controller: 'items', action: 'index', format: :csv, export: params["export"].permit!
    end


    respond_to do |format|
      format.html do
        @items = Item.all
      end

      format.csv do
        if params["export"]
          cases = params["export"]["cases"].reject(&:empty?)
        else
          cases = []
        end

        if cases.count > 0
          @items = []

          cases.each do |c|
            Item.where("case_id = #{c} and price >= #{params['export']['price']}").each{ |i| @items << i }
          end
          p @items
        else
          @items = Item.all
        end
      end
    end
  end


  def new
    @item = Item.new(case: Case.find(params[:case_id]))
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to case_path(@item.case)
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @item.update_attributes(item_params)
      redirect_to case_path(@item.case)
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

  def export
    @cases = Case.all
  end

  def clone
    item = Item.find(params[:id]).dup
    item.name = "Copy of #{item.name}"

    if item.save
      redirect_to edit_item_path(@item)
    else
      redirect_to item_path(Item.find(params[:id]))
    end
  end

  private

  def find_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :manufacturer, :model,
                                 :item_id, :case_id, :date_of_purchase,
                                 :price, :serial_number, :broken, :missing,
                                 :item_type_id)
  end

end
