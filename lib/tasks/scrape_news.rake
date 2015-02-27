namespace :scrape_news do 
  require "net/http"
  require "uri"


  desc "scrape infoplease for news and sports"
  task :news => :environment do |t, args|

    require 'open-uri'
    require 'nokogiri'

    for year in 2000..2012 do
    # for year in 1990..2015 do

      url = "http://www.infoplease.com/year/#{year}.html"

      begin
        document = open(url).read
        html_doc = Nokogiri::HTML(document)
        puts html_doc.css('title').text
      rescue OpenURI::HTTPError => ex
        puts "Missing URL"
        return
      end

      data_news = "#Pg > ul:nth-child(8) > li"
      newsList = html_doc.css(data_news)
      
      newsArray = [];
      for item in newsList
        newsArray.push(item.text)
        # if (news.length == 5) then 
        #   return
        # end
      end
      # puts newsArray

      # sports is plain text - no css!!!
      # data_sports = "table > tbody > tr > td"
      # xpath = "//*[@id='Pg']/text()"
      # sportsList = html_doc.xpath(xpath)
      # sports = [];
      # for item in sportsList
      #   if not (item.text.include? "\n")
      #     sports.push(item.text)
      #   end
      # end    
      # sports.reject! { |s| s.empty? }
      # puts sports;

      news = NewsArticle.create(year: year, news: newsArray)

      # puts news.inspect


    end

  end

end