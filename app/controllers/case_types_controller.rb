# frozen_string_literal: true

class CaseTypesController < ApplicationController
  before_action :find_case_type, except: %i[index create new]

  def index
    @case_types = CaseType.all
  end

  def show; end

  def new
    @case_type = CaseType.new
  end

  def edit; end

  def create
    @case_type = CaseType.new(case_params)

    if @case_type.save
      redirect_to case_types_path, notice: "Created case type '#{@case_type.name}'"
    else
      render action: "new"
    end
  end

  def update
    if @case_type.update(case_params)
      redirect_to case_types_path, notice: "Updated case type '#{@case_type.name}'"
    else
      render action: "edit"
    end
  end

  def destroy
    if @case_type.destroy
      redirect_to case_types_path, notice: "Deleted case type '#{@case_type.name}'"
    else
      render action: "show"
    end
  end

  private

  def find_case_type
    @case_type = CaseType.find(params[:id])
  end

  def case_params
    params.expect(case: [ :name ])
  end
end
