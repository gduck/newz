namespace :get_zodiacs do 
  desc "scrape chinese horoscopes"
  task :both => :environment do 

    require 'open-uri'
    require 'nokogiri'

    url = "http://www.chinesezodiac.com/signs.php"

    puts "I'm here!!!"
    
    begin
      document = open(url).read
      html_doc = Nokogiri::HTML(document)
      puts html_doc.css('title').text
    rescue OpenURI::HTTPError => ex
      puts "Missing URL"
      return
    end

    data_animals = "div > div > div.entry-content > p > a"
    animals = html_doc.css(data_animals)

    return "Rat"

  end
end
