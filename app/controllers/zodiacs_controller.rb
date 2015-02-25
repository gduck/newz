class ZodiacsController < ApplicationController

  def find
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    @currentDate = params[:date]
    
    sign = getZodiac
    thisZodiac = Zodiac.find_by_sign(sign)
    
    animal = getAnimal
    thisAnimal = ChineseHoroscope.find_by_animal(animal)

    # @horoscopes = {
    #   'zodiac' => zod.sign,
    #   'animal' => ani.animal
    # }
    @zodiac = thisZodiac
    @animal = thisAnimal
    # puts "@zodiac >>>>> #{@zodiac}"
    # puts "@animal >>>>> #{@animal}"

    
    # puts @data
    # @data.zodiac = Zodiac.find_by_sign(sign)
    # @data.animal = ChineseHoroscope.find_by_animal(animal)

    render 'find.json.jbuilder'
  end

  def getAnimal
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

    return "Rat"
  end

  def getZodiac
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

    return "Leo"

  end
end
