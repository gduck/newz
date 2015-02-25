namespace :scrape_songs do 
  desc "scrape top 5 songs for a given year"
  task :songs => :environment do 

    require 'open-uri'
    require 'nokogiri'

    #  can call like this if you want
    # rake scrapeMovies:movies date="xx"
    # year = ENV['year']

    for year in 1947..2015 do
      url = "http://www.bobborst.com/popculture/songoftheyear/#year#{year}"

      begin
        document = open(url).read
        html_doc = Nokogiri::HTML(document)
        # puts html_doc.css('title').text
      rescue OpenURI::HTTPError => ex
        puts "Missing URL"
        return
      end

      divId = "#year" + year.to_s
      data_songs = divId + " > div > div > ol > li"
      puts data_songs
      # div:nth-child(30).cb > div:nth-child(2) > div:nth-child(2) > ol:nth-child(1).songofyear > li
      songs = html_doc.css(data_songs)

      songlist = []
      songs.each_with_index do |song, index|
        #  must remove extra \n in last song
        songlist.push(song.children[0].text)
      end
      puts songlist
      sl = Songlist.new(year: year, songs: songlist)
      sl.save
      puts sl.inspect
    end
  end
end