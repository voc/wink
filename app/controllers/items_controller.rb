require 'csv'

class ItemsController < ApplicationController

  before_action :find_item, except: [:index, :create, :new, :export]

  def show
    @subitems = Item.where(item: @item)

    respond_to do |format|
      format.html
      format.json { render :json => @item.to_json }
    end
  end

  def index
    if params['commit'].in?(['Export', 'Download', 'Preview'])
      redirect_to controller: 'items', action: 'index', format: :csv, export: params['export'].permit!, download: params['commit'] == 'Download'
    end


    respond_to do |format|
      format.html do
        @items = Item.all.where(deleted: false)
      end

      format.json do
        @items = Item.all.where(deleted: false)

        render json: @items
      end

      format.csv do
        filter = ''
        if params['download']
          headers["Content-Type"] ||= 'text/csv'
          headers["Content-Disposition"] = "attachment; filename=\"export.csv\"" 
        end

        if params["export"]
          cases = params["export"]["cases"].reject(&:empty?)
        else
          cases = []
        end

        unless params['export']['price'].empty?
          filter += " and price >= #{params['export']['price']}"
        end

        unless params['export']['item_type_id'].empty?
          filter += " and item_type_id IN(#{params['export']['item_type_id'].reject { |c| c.empty? }.join(',')})"
        end

        if cases.count > 0
          @items = []

          cases.each do |c|
            Item.where("case_id = #{c}" + filter).where(deleted: false).each{ |i| @items << i }
          end
          p @items
        else
          @items = Item.all.where(deleted: false)
        end
      end
    end
  end


  def new
    @item = Item.new(case: Case.find(params[:case_id]))
    if params[:location]
      @item.location_item_id = params[:location]
    end
    @locations = ItemType.where(case_id: @item.case).order(:name)
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to case_path(@item.case), notice: "Created item #{@item.name}"
    else
      render action: 'new'
    end
  end

  def edit
    if @item.deleted == true
      redirect_to item_path(@item), notify: "Item is still deleted!"
    end
  end

  def update
    if @item.case_id != item_params[:case_id]
      @item.location = nil
      @item.save
    end

    if @item.update_attributes(item_params)
      # move subitems to same case
      @item.move_sub_items

      redirect_to case_path(@item.case), notice: "Updated '#{@item.name}'"
    else
      render action: 'edit'
    end
  end

  def delete
  end

  def destroy
    @item.destroy
    redirect_to case_path(@item.case), notice: "Disabled '#{@item.name}' in case '#{@item.case.acronym}'"
  end

  def export
    @cases = Case.all
  end

  def clone
    new_item = @item.clone_item
    if new_item
      redirect_to edit_item_path(new_item)
    else
      redirect_to item_path(Item.find(params[:id]))
    end
  end

  private

  def find_item
    @item = Item.unscoped.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :manufacturer, :model,
                                 :item_id, :case_id, :date_of_purchase,
                                 :price, :serial_number, :broken, :missing,
                                 :item_type_id, :location_item_id)
  end

  def import 
    # TBD, require './importer2' ...

  end
end
