# frozen_string_literal: true

require "csv"

class ItemsController < ApplicationController
  before_action :find_item, except: %i[index create new export]

  def index
    if params["commit"].in?(%w[Export Download Preview])
      redirect_to controller: "items", action: "index", format: :csv, export: params["export"].permit!,
                  download: params["commit"] == "Download"
    end

    respond_to do |format|
      format.html do
        @items = Item.where(deleted: false)
      end

      format.json do
        @items = Item.where(deleted: false)

        render json: @items
      end

      format.csv do
        filter = ""
        headers["Content-Type"] ||= "text/csv"
        if params["download"].in?([ true, "true" ])
          headers["Content-Disposition"] = "attachment; filename=\"export.csv\""
        end

        cases = if params["export"]
          params["export"]["cases"].reject(&:empty?)
        else
          []
        end

        filter += " and price >= #{params['export']['price']}" unless params["export"]["price"].empty?

        unless params["export"]["item_type_id"].empty? || params["export"]["item_type_id"] == [ "" ]
          filter += " and item_type_id IN(#{params['export']['item_type_id'].reject(&:empty?).join(',')})"
        end

        if cases.any?
          @items = []

          cases.each do |c|
            Item.where("case_id = #{c}" + filter).where(deleted: false).find_each { |i| @items << i }
          end
          Rails.logger.debug @items
        else
          @items = Item.where(deleted: false)
        end
      end
    end
  end

  def show
    @subitems = Item.where(item: @item)

    respond_to do |format|
      format.html
      format.json { render json: @item.to_json }
    end
  end

  def new
    @item = Item.new(case: Case.find(params[:case_id]))
    @item.location_item_id = params[:location] if params[:location]
    @locations = ItemType.where(case_id: @item.case).order(:name)
  end

  def edit
    return unless @item.deleted == true

      redirect_to item_path(@item), notify: "Item is still deleted!"
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to case_path(@item.case), notice: "Created item #{@item.name}"
    else
      render action: "new"
    end
  end

  def update
    if @item.case_id != item_params[:case_id]
      @item.location = nil
      @item.save
    end

    if @item.update(item_params)
      # move subitems to same case
      @item.move_sub_items

      redirect_to case_path(@item.case), notice: "Updated '#{@item.name}'"
    else
      render action: "edit"
    end
  end

  def destroy
    if @item.destroy
      redirect_to case_path(@item.case), notice: "Disabled '#{@item.name}' in case '#{@item.case.acronym}'"
    else
      render action: "show"
    end
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
    params.expect(item: %i[name description manufacturer model
                           item_id case_id date_of_purchase
                           price serial_number broken missing
                           item_type_id location_item_id])
  end
end
