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
      animalSign =  animal.text
      count1 = animalSign.length
      count2 = description[index + 1].text.length + 1
      text = description[index + 1].text.slice(count1, count2)
      newEntry = ChineseHoroscope.create(animal: animalSign, description: text)
      puts newEntry.inspect
    end
  end

  desc "scrape western zodiacs"
  task :zodiacs => :environment do 

    require 'open-uri'
    require 'nokogiri'

    url = "http://www.zodiac-signs.co.uk/"

    begin
      document = open(url).read
      html_doc = Nokogiri::HTML(document)
    rescue OpenURI::HTTPError => ex
      puts "Missing URL"
      return
    end

    data_signs = "div > div > div:nth-child(13) > p:nth-child(1).c3 > a"
    signs = html_doc.css(data_signs)
    signs.each do |sign|
      scrapePage(url + sign.attr('href'), sign.text)
    end
  end

  def scrapePage(url, starSign) 
    
    begin
      document = open(url).read
      html_doc = Nokogiri::HTML(document)
    rescue OpenURI::HTTPError => ex
      puts "Missing URL"
      return
    end

    data_description = "body > div > div > div:nth-child(4) > p:nth-child(4)"
    description = html_doc.css(data_description)
  
    newEntry = Zodiac.create(sign: starSign, description: description.text)
    puts newEntry.inspect
  end
end
