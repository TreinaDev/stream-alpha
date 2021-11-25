class PlaylistsController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create]
  before_action :authenticate_admin_client_streamer!, only: %i[show]

  def new
    @playlist = current_admin.playlists.new
    @videos = Video.available.order(name: :asc)
    @streamers = StreamerProfile.all_actives.order(name: :asc)
  end

  def create
    @playlist = current_admin.playlists.build(playlist_params)

    if @playlist.save
      redirect_to @playlist, notice: t('.success')
    else
      flash['alert'] = t('.failed')
      render :new
    end
  end

  def show
    @playlist = Playlist.find(params[:id])
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name, :description, :cover, video_ids: [], streamer_ids: [])
  end
end
