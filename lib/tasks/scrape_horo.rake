namespace :scrape_horo do 
  desc "scrape chinese horoscopes"
  task :chinese => :environment do 

    require 'open-uri'
    require 'nokogiri'

    url = "http://www.chinesezodiac.com/signs.php"

    begin
      document = open(url).read
      html_doc = Nokogiri::HTML(document)
      # puts html_doc.css('title').text
    rescue OpenURI::HTTPError => ex
      puts "Missing URL"
      return
    end

    data_animals = "div > div > div.entry-content > p > a"
    animals = html_doc.css(data_animals)

    data_description = "div > div > div > div.entry-content > p"
    description = html_doc.css(data_description)
    # description.shift

    animals.each_with_index do |animal, index|
      puts animal.text
      count1 = animal.text.length
      count2 = description[index + 1].text.length + 1
      puts description[index + 1].text.slice(count1, count2)
    end
  end

  desc "scrape western zodiacs"
  task :zodiacs => :environment do 
    

  end

end
