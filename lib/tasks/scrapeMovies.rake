namespace :scrapeMovies do 
  require "net/http"
  require "uri"


  desc "scrape imdb.com for list of best movies"
  task :movies => :environment do |t, args|

    require 'open-uri'
    require 'nokogiri'

    #  can call like this if you want
    # rake scrapeMovies:movies year="2000"
    year = ENV['year']
    # puts "year is #{year}"

    for year in 1940..2015 do

      url = "http://www.imdb.com/event/ev0000003/#{year}"


      begin
        document = open(url).read
        html_doc = Nokogiri::HTML(document)
        puts html_doc.css('title').text
      rescue OpenURI::HTTPError => ex
        puts "Missing URL"
        return
      end


      data_movies = "blockquote > blockquote:nth-child(2) > div > strong:nth-child(2) > a:nth-child(1)"
      movies = html_doc.css(data_movies)

      count = movies.count
      if count == 0 then
        puts "big problem - no movies"
        return
      end

      
      bestMovie = movies[0].text;
      # puts "best movie #{bestMovie}"
      movies.shift

      # puts "the other #{count - 1} nominees"
      nominees = [];
      for movie in movies
        nominees.push(movie.text) 
      end
      # puts nominees

      data_producers = "div.award > blockquote > blockquote:nth-child(2) > div:nth-child(2).alt > a"
      producerList = html_doc.css(data_producers)
      
      # note sometimes the site lists no actors,
      # only the studio, sometimes the producers etc
      # puts "producers or studio"
      producers = [];
      for item in producerList
        producers.push(item.text)
      end
      # puts producers
    

      movieEntry = Movie.create(year: year, bestMovie: bestMovie, nominees: nominees, producers: producers)

      puts movieEntry.inspect


    end

  end

end