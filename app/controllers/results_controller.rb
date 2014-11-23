class ResultsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_track

  def index
    @results = @track.results.all
  end

  def destroy
    @result = @track.results.find(params[:id])
    @result.destroy
    redirect_to event_tracks_path(@track.event, @track), notice: 'Result was successfully destroyed.'
  end

  private
    def set_track
      @track = Track.find(params[:track_id])
    end

end
