class ResultsController < ApplicationController

  before_action :authenticate_user!

  def index
    @track = Track.find(params[:track_id])
    @results = @track.results.all
  end

  def destroy
    @result = Result.find(params[:id])
    @result.destroy
    redirect_to event_track_results_path(@result.track.event, @result.track), notice: 'Result was successfully destroyed.'
  end

end
