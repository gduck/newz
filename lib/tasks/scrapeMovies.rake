namespace :scrapeMovies do 
  require "net/http"
  require "uri"


  desc "scrape imdb.com for list of best movies"
  task :movies => :environment do |t, args|

    require 'open-uri'
    require 'nokogiri'

    #  can call like this if you want
    # rake scrapeMovies:movies year="2000"
    # year = ENV['year']
    # puts "year is #{year}"

    for year in 1940..2015 do
    # for year in 1990..2015 do

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
      movies.shift

      nominees = [];
      for movie in movies
        nominees.push(movie.text) 
      end

      data_producers = "div.award > blockquote > blockquote:nth-child(2) > div:nth-child(2).alt > a"
      producerList = html_doc.css(data_producers)
      
      # note sometimes the site lists no actors,
      # only the studio, sometimes the producers etc
      # puts "producers or studio"
      producers = [];
      for item in producerList
        producers.push(item.text)
      end
    
      data_best_actor = "div.award > blockquote > blockquote:nth-child(4) > div:nth-child(2).alt > a:nth-child(3)"
      best_actor = html_doc.css(data_best_actor).text
      # puts best_actor

      data_best_actor_in = "blockquote > blockquote:nth-child(4) > div:nth-child(2).alt > strong:nth-child(2) > a:nth-child(1)"
      best_actor_in = html_doc.css(data_best_actor_in).text
      # puts best_actor_in

      data_best_actress = "div.award > blockquote > blockquote:nth-child(6) > div:nth-child(2).alt > a:nth-child(3)"
      best_actress = html_doc.css(data_best_actress).text
      # puts best_actress

      data_best_actress_in = "blockquote > blockquote:nth-child(6) > div:nth-child(2).alt > strong:nth-child(2) > a:nth-child(1)"
      best_actress_in = html_doc.css(data_best_actress_in).text 
      # puts best_actress_in   

      movieEntry = Movie.create(year: year, bestMovie: bestMovie, nominees: nominees, producers: producers, bestActor: best_actor, bestActorMovie: best_actor_in, bestActress: best_actress, bestActressMovie: best_actress_in)

      puts movieEntry.inspect


    end

  end

end