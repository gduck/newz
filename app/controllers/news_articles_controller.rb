class NewsArticlesController < ApplicationController

  def show
    @newsArticles = NewsArticle.find_by_year(params[:year])
    puts ">>>>>>>>>>>>>>>>>>>>"
    puts @newsArticles.inspect
  end

end
