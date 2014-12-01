class Api::V1::TracksController < Api::BaseController
  def index
    @tracks = Track.all
  end

  def show
    @track = Track.find(params[:id])
  end

  def search
    @track = Track.where(info_tag: params[:info_tag]).first
    render :show
  end

  def result
    track = Track.find(params[:id])
    @result = track.results.new(results_params)
    @result.control_points = params[:control_points]
    if @result.save
      head 201
    else
      render json: { error: @result.errors }, status: 422
    end
  end

  private
  def results_params
    params.permit(:nickname, :total_time, :complete)
  end

end
