class ItemCommentsController < ApplicationController

  before_action :find_item_comment, except: [:index, :create, :new]
  before_action :find_item, only: [:index, :create, :new]

  def show
  end

  def index
    @item_comments = @item.item_comments
  end

  def new
    @item_comment = @item.item_comments.new
  end

  def create
    @item_comment = @item.item_comments.new item_comment_params

    if @item_comment.save!
      redirect_to item_path(@item), notice: "Created comment for item '#{@item.name}'"
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @item_comment.update(item_comment_params)
      redirect_to item_path(@item_comment.item), notice: "Updated item comment for '#{@item_comment.item.name}'"
    else
      render action: 'edit'
    end
  end

  def delete
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
    params.require(:item_comment).permit(:author, :comment, :user_id)
  end

end
