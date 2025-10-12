# frozen_string_literal: true

class ItemCommentsController < ApplicationController
  before_action :find_item_comment, except: %i[index create new]
  before_action :find_item

  def index
    @item_comments = ItemComment.where(item_id: params[:item_id])
  end

  def show; end

  def new
    @item_comment = ItemComment.new(item_id: Item.find(params[:item_id]))
  end

  def edit; end

  def create
    @item_comment = ItemComment.new(item_comment_params)
    @item_comment.item_id = @item.id

    if @item_comment.save!
      Rails.logger.debug @item_comment
      redirect_to item_path(@item), notice: "Created comment for item '#{@item.name}'"
    else
      render action: "new"
    end
  end

  def update
    if @item_comment.update(item_comment_params)
      redirect_to item_path(@item.id), notice: "Updated item comment for '#{@item.name}'"
    else
      render action: "edit"
    end
  end

  def destroy
    @item_comment.destroy!
    redirect_to item_path(@item), notice: "Deleted comment"
  end

  private

  def find_item
    @item = Item.find(params[:item_id])
  end

  def find_item_comment
    @item_comment = ItemComment.find(params[:id])
  end

  def item_comment_params
    params.expect(item_comment: %i[author comment])
  end
end
