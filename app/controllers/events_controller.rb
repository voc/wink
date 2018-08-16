require 'net/http'

class EventsController < ApplicationController

  before_action :find_event, except: [:index, :create, :new, :import_events]

  def show
  end

  def index
    @events = Event.all.order(start_date: :desc)
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

end
