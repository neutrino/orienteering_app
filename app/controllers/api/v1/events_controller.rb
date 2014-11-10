class Api::V1::EventsController < Api::BaseController

  def index
    @events = Event.all
    # render json: @events.to_json
  end

  def show
    @event = Event.find(params[:id])
  end
end
