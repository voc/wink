require 'net/http'

class EventsController < ApplicationController

  before_action :find_event, except: [:index, :create, :new, :import_events]

  def show
    respond_to do |format|
      format.html
      format.json { render :json => @event.to_json }
    end
  end

  def index
    @events = Event
      .includes(:cases)
      .where(start_date: DateTime.new(0)..DateTime.now.end_of_year)
      .order(start_date: :desc)

    respond_to do |format|
      format.html
      format.json { render :json => @events.to_json }
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to events_path
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      render action: 'edit'
    end
  end

  def delete
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  def import_events
    uri = URI("https://c3voc.de/eventkalender/events.json")
    json = JSON.parse(Net::HTTP.get(uri))

    json["voc_events"].each do |event,values|
      event = Event.find_by(name: "#{values['name']}")
      unless event
        event = Event.new
      end

      event.name = values['name']
      event.location = values['location']
      event.start_date = Date.parse(values['start_date'])
      event.end_date = Date.parse(values['end_date'])
      unless values['buildup'].nil?
        event.buildup = DateTime.parse(values['buildup'])
      end
      unless values['teardown'].nil?
        event.removel = DateTime.parse(values['teardown'])
      end
      event.save
    end

    redirect_to events_path
  end

  private

  def find_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :start_date, :end_date,
                                  :removel, :location, :buildup,
                                  :case_ids).tap do |whitelisted|
      whitelisted[:case_ids] = params[:event][:case_ids]
    end
  end

end
