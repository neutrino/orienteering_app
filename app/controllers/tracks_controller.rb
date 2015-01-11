class TracksController < ApplicationController

  before_action :authenticate_user!
  before_action :set_track, only: [:show, :edit, :update, :destroy, :sort]

  def index
    @event = Event.find(params[:event_id])
    @tracks = @event.tracks.all
  end

  def show
  end

  def new
    @event = Event.find(params[:event_id])
    @track = @event.tracks.build
    3.times { @track.control_points.build }
  end

  def edit
    @track.control_points.build
  end

  def create
    @event = Event.find(params[:event_id])
    @track = @event.tracks.new(track_params)
    if @track.save
      redirect_to event_tracks_url(@event), notice: 'Track was successfully created.'
    else
      render :new
    end
  end

  def update
    if @track.update(track_params)
      redirect_to event_tracks_url(@event), notice: 'Track was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @track.destroy
    redirect_to event_tracks_url(@event), notice: 'Track was successfully destroyed.'
  end


  def sort
    params[:control_point].each_with_index do |id, index|
      control_point = @track.control_points.find(id)
      control_point.update_attribute(:position, index) if control_point
    end
    render nothing: true
  end


  private
    def set_track
      @event = Event.find(params[:event_id])
      @track = Track.find(params[:id])
    end

    def track_params
      params.require(:track).permit(:distance, :name, :image, :info_tag, control_points_attributes: [:id, :tag_id])
    end
end
