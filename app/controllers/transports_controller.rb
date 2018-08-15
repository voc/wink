class TransportsController < ApplicationController

  before_action :find_transport, except: [:index, :create, :new]

  def show
  end

  def index
    @transports = Transport.all
  end

  private

  def find_transport
    @transport = Transport.find(params[:id])
  end

end
