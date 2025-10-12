# frozen_string_literal: true

class CasesController < ApplicationController
  before_action :find_case, except: %i[index create new]

  def index
    @cases = {}
    CaseType.find_each do |type|
      @cases[type.name] = []
      Case.where(case_type: type).find_each do |c|
        @cases[type.name] << c
      end
    end

    respond_to do |format|
      format.html
      format.json { render json: Case.all.to_json }
    end
  end

  def show
    @grouped_shelfs = @case.locations.group_by { |i| i.location.nil? ? i.name : i.location.name }

    @items_without_sections = @case.items.where(deleted: false) - @case.sections
    @grouped_items = @items_without_sections.group_by(&:location)

    @flagged_items = @case.flagged_items
    @deleted_items = Item.where(case: @case, deleted: true)

    respond_to do |format|
      format.html
      format.json { render json: @case.to_json }
    end
  end

  def new
    @case = Case.new
  end

  def edit; end

  def create
    @case = Case.new(case_params)

    if @case.save
      redirect_to cases_path
    else
      render action: "new"
    end
  end

  def update
    if @case.update(case_params)
      redirect_to cases_path
    else
      render action: "edit"
    end
  end

  def destroy
    if @case.destroy
      redirect_to cases_path, notice: "Deleted case '#{@case.name}'"
    else
      render action: "show"
    end
  end

  private

  def find_case
    @case = Case.find(params[:id])
  end

  def case_params
    params.expect(case: %i[name acronym case_type_id])
  end
end
