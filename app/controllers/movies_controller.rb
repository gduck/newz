class MoviesController < ApplicationController

  def show
    @movieEntry = Movie.find_by_year(params[:year])
  end


  protected
  def permitted_params 
    params.require(:movie).permit(:year)
  end

end
