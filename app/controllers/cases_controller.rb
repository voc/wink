class CasesController < ApplicationController

  before_action :find_case, except: [:index, :create, :new]

  def show
    shelfs = @case.locations.where(deleted: false)
    @items_without_shelfs = @case.items.where(deleted: false) - shelfs

    @grouped_items = @items_without_shelfs.group_by do |i|
      i.location
    end

    @missing_items = Item.where(case: @case, missing: true, deleted: false)
    @deleted_items = Item.where(case: @case, deleted: true)

    @upcoming_events = Event.where(end_date: Date.today-2..4.weeks.after).order(:start_date)

    respond_to do |format|
      format.html
      format.json { render json: @case.to_json }
    end
  end

  def index
    @cases = {}
    CaseType.all.each do |type|
      @cases[type.name] = []
      Case.where(case_type: type).each do |c|
        @cases[type.name] << c
      end
    end

    respond_to do |format|
      format.html
      format.json { render json: Case.all.to_json }
    end
  end

  def new
    @case = Case.new
  end

  def create
    @case = Case.new(case_params)

    if @case.save
      redirect_to cases_path
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @case.update_attributes(case_params)
      redirect_to cases_path
    else
      render action: 'edit'
    end
  end

  def delete
  end

  def destroy
    @case.destroy
    redirect_to cases_path
  end

  private

  def find_case
    @case = Case.find(params[:id])
  end

  def case_params
    params.require(:case).permit(:name, :acronym, :case_type_id)
  end
end
