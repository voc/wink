class EventsController < ApplicationController

  before_action :find_event, except: [:index, :create, :new]

  def show
  end

  def index
    @events = Event.all
  end

  private

  def find_event
    @event = Event.find(params[:id])
  end

end
