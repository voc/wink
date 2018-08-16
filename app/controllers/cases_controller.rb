class CasesController < ApplicationController

  before_action :find_case, except: [:index, :create, :new]

  def show
    @items = @case.items
  end

  def index
    @cases = {}
    CaseType.all.each do |type|
      @cases[type.name] = []
      Case.where(case_type: type).each do |c|
        @cases[type.name] << c
      end
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
