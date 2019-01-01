class CheckListsController < ApplicationController

  before_action :find_check_list, except: [:index, :create, :new]

  def show
    respond_to do |format|
      format.html
      format.json { render json: @check_list.to_json }
    end
  end

  def index
    @check_lists = CheckList.all

    respond_to do |format|
      format.html
      format.json { render json: @check_lists.to_json }
    end
  end

  def new
    @event_case = EventCase.find_by(event_id: params[:event], case_id: params[:case])

    if @event_case.check_list
      redirect_to check_list_path(@event_case.check_list)
    else
      @event_case.check_list = CheckList.new
    end
  end

  def create
    @event_case = EventCase.find(event_case_params[:event_case])
    @event_case.check_list = CheckList.new(check_list_params)

    if @event_case.save!
      # TODO: move that into the model
      @event_case.check_list.copy_items!

      redirect_to check_list_path(@event_case.check_list)
      # TODO: Send mqtt message, when checklist was created.
    else
      render action: 'new'
    end
  end

  def edit
    shelfs = @check_list.locations
    @check_list_items = @check_list.check_list_items - shelfs
    @check_list_items = @check_list_items.select { |cli| !cli.item.is_deleted? }

    @grouped_items = @check_list_items.group_by do |cli|
      next if cli.item.shelf?

      if cli.item.location.nil?
        ""
      else
        "#{cli.item.location.name}"
      end
    end
  end

  # Check checklist.
  def update
    CheckList.find(params[:id]).check_list_items.each do |cli|
      if checked_check_list_params[:checked_check_list_items].include?("#{cli.id}")
        cli.checked = true
      else
        cli.checked = false
      end

      if cli.save!
        next
      else
        render action: 'edit'
      end
    end

    if ActiveModel::Type::Boolean.new.cast(check_list_params[:checked])
      @check_list.checked = true
      # Mark items as missing and add comment.
      mark_missing_items(@check_list)
      #
      # TODO: Send mqtt message, when checklist is finished.
      Wink::MqttClient.send_message("'#{@check_list.advisor}' finished '#{@check_list.event.name}' checklist for '#{@check_list.case.name}'")
    else
      @check_list.checked = false
    end

    @check_list.save!

    redirect_to check_list_path(params[:id])
  end

  def delete
  end

  def destroy
    # TODO: Disable checklist deletion in views.
    @check_list.destroy
    redirect_to check_lists_path
  end

  private

  def find_check_list
    @check_list = CheckList.find(params[:id])
  end

  def check_list_params
    params.require(:check_list).permit(:comment, :advisor, :checked)
  end

  def checked_check_list_params
    params.require(:check_list).permit(checked_check_list_items: [])
  end

  def event_case_params
    params.require(:check_list).permit(:event_case)
  end

  def mark_missing_items(checklist)
    checklist.items_without_shelfs.each do |checklist_item|
      # Mark items as missing when checklist is finished and items on list are
      # not checked.
      if checklist_item.checked == false
        item = checklist_item.item
        item.missing = true
        item.save!

        ItemComment.create(
          author: "WINK",
          comment: "Item marked as missing by '#{checklist.advisor}' during '#{checklist.event.name}'.",
          item_id: checklist_item.item.id
        )
      end
    end
    # TODO: Copy broken state to items and create
    #       a comment containing the event and checklist number.
  end
end
