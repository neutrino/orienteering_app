class ResultsController < ApplicationController

  before_action :authenticate_user!, :except => [:events, :event, :overall, :splits]

  def index
    @track = Track.find(params[:track_id])
    @results = @track.results.all
  end

  def destroy
    @result = Result.find(params[:id])
    @result.destroy
    redirect_to event_track_results_path(@result.track.event, @result.track), notice: 'Result was successfully destroyed.'
  end

  def events
    @events = Event.all
  end

  def event
    @event = Event.find(params[:event_id])
    @tracks = @event.tracks.all
  end

  def overall
    @event = Event.find(params[:event_id])
    @track = Track.find(params[:track_id])
    @results = @track.results.all.sort_by { |r| r.total_time.to_i }
  end

  def splits
    @event = Event.find(params[:event_id])
    @track = Track.find(params[:track_id])
    @control_points = @track.control_points.all
    @results = @track.results.all.sort_by { |r| r.total_time.to_i }
  end

end
