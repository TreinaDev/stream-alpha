class PlaylistsController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create]
  before_action :authenticate_admin_client_streamer!, only: %i[show]

  def new
    @playlist = current_admin.playlists.new
    @videos = Video.approved.order(name: :asc)
    @streamers = StreamerProfile.active.order(name: :asc)
  end

  def create
    @playlist = current_admin.playlists.build(playlist_params)
    @videos = Video.approved.order(name: :asc)
    @streamers = StreamerProfile.active.order(name: :asc)

    if @playlist.save
      redirect_to @playlist, notice: t('.success')
    else
      flash[:alert] = t('.failure')
      render :new
    end
  end

  def show
    @playlist = Playlist.find(params[:id])
  end

  def index
    @playlists = Playlist.all
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name, :description, :cover, video_ids: [], streamer_ids: [])
  end
end
