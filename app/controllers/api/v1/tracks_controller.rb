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
    @track = Track.find(params[:id])
    @track.results.create(results_params)
    head 201
  end

  private
  def results_params
    params.require(:result).permit(:nickname, :details)
  end

end
