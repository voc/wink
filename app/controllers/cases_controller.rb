class CasesController < ApplicationController

  before_action :find_case, except: [:index, :create, :new]

  def show
  end

  def index
    @cases = Case.all
  end

  private

  def find_case
    @case = Case.find(params[:id])
  end

end
