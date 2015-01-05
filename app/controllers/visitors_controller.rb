class VisitorsController < ApplicationController

  def index
    @active_events = Event.active.includes(:tracks)
  end

end
