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

  private

  def find_case
    @case = Case.find(params[:id])
  end

end
