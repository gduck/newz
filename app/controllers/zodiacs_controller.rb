class ZodiacsController < ApplicationController

  def find
    dateArray = params[:date].split('-')
    @year = dateArray[0]
    @month = dateArray[1]
    @day = dateArray[2]

    sign = getZodiac
    thisZodiac = Zodiac.find_by_sign(sign)
    
    animal = getAnimal
    thisAnimal = ChineseHoroscope.find_by_animal(animal)

    @zodiac = thisZodiac
    @animal = thisAnimal
 
    render 'find.json.jbuilder'
  end

  def getAnimal
    require 'open-uri'
    require 'nokogiri'

    url = "http://www.miniwebtool.com/what-is-my-chinese-zodiac-sign/?birthday_month=#{@month}&birthday_day=#{@day}&birthday_year=#{@year}"
    
    begin
      document = open(url).read
      html_doc = Nokogiri::HTML(document)
      # puts html_doc.css('title').text
    rescue OpenURI::HTTPError => ex
      puts "Missing URL"
      return
    end

    data_animal = "body > div > div > div > b"
    animal = html_doc.css(data_animal)
    return animal.text
  end

  def getZodiac
    require 'open-uri'
    require 'nokogiri'

    url = "http://www.miniwebtool.com/what-is-my-zodiac-sign/?birthday_month=#{@month}&birthday_day=#{@day}&birthday_year=#{@year}"
    
    begin
      document = open(url).read
      html_doc = Nokogiri::HTML(document)
      puts html_doc.css('title').text
    rescue OpenURI::HTTPError => ex
      puts "Missing URL"
      return
    end

    data_zodiac = "body > div > div > div > b"
    zodiac = html_doc.css(data_zodiac)
    return zodiac.text

  end
end
