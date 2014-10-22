class TracksController < ApplicationController
  before_action :set_track, only: [:show, :edit, :update, :destroy]


  def index
    @event = Event.find(params[:event_id])
    @tracks = @event.tracks.all
  end

  def show
  end

  def new
    @event = Event.find(params[:event_id])
    @track = @event.tracks.build
  end

  def edit
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
    redirect_to tracks_url, notice: 'Track was successfully destroyed.'
  end

  private
    def set_track
      @event = Event.find(params[:event_id])
      @track = Track.find(params[:id])
    end

    def track_params
      params.require(:track).permit(:distance, :name, :image)
    end
end
