class SonglistsController < ApplicationController
  def show
    @songlist = Songlist.find_by_year(params[:year])
  end

end
