class SonglistsController < ApplicationController
  def show
    @songlist = Songlist.find_by_year(params[:year])
  end


  protected
  def permitted_params 
    params.require(:songlist).permit(:year)
  end
end
