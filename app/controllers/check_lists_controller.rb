class CheckListsController < ApplicationController

  before_action :find_check_list, except: [:index, :create, :new]

  def show
  end

  def index
    @check_lists = CheckList.all
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
      @event_case.check_list.copy_items!

      redirect_to check_list_path(@event_case.check_list)
    else
      render action: 'new'
    end
  end

  def edit
    shelfs = @check_list.locations
    @check_list_items = @check_list.check_list_items - shelfs

    @grouped_items = @check_list_items.group_by do |cli|
      next if cli.item.shelf?

      if cli.item.location.nil?
        ""
      else
        "#{cli.item.location.name}"
      end
    end
  end

  def update
    p params
    return

    if @check_list.update_attributes(check_list_params)
      redirect_to check_lists_path
    else
      render action: 'edit'
    end
  end

  def delete
  end

  def destroy
    @check_list.destroy
    redirect_to check_lists_path
  end

  private

  def find_check_list
    @check_list = CheckList.find(params[:id])
  end

  def check_list_params
    params.require(:check_list).permit(:comment, :advisor)
  end

  def event_case_params
    params.require(:check_list).permit(:event_case)
  end

end
