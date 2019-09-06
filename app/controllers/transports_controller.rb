class TransportsController < ApplicationController

  before_action :find_transport, except: [:index, :create, :new]

  def show
  end

  def index
    @transports = Transport.all
  end

  def new
    @transport = Transport.new
  end

  def create
    @transport = Transport.new(transport_params)

    if @transport.save
      redirect_to edit_transport_path
    else
      render action: 'new'
    end
  end

  def update
    if @transport.update_attributes(transport_params)
      redirect_to transports_path
    else
      render action: 'edit'
    end
  end

  private

  def find_transport
    @transport = Transport.find(params[:id])
  end

  def transport_params
    params.require(:transport).permit(:source_event_id, :source_address, :destination_event_id, :destination_address)
  end

end
