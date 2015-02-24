namespace :scrapeMovies do 
  require "net/http"
  require "uri"


  desc "scrape oscars.org for list of best movies"
  task :movies => :environment do

    require 'open-uri'
    require 'nokogiri'

    yearStr = "1963"

    url = "http://www.imdb.com/event/ev0000003/" + yearStr


    begin
      document = open(url).read
      html_doc = Nokogiri::HTML(document)
      puts html_doc.css('title')
    rescue OpenURI::HTTPError => ex
      puts "Missing URL"
      return
    end



    data_bestMovie = "blockquote > blockquote:nth-child(2) > div > strong:nth-child(2) > a:nth-child(1)"
    movies = html_doc.css(data_bestMovie)
    # puts movie.text

    for movie in movies
      puts movie.text
    end

    data_actors = "div.award > blockquote > blockquote:nth-child(2) > div:nth-child(2).alt > a"
    actors = html_doc.css(data_actors)
    puts actors

  end

end