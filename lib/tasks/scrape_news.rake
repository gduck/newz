namespace :scrape_news do 
  require "net/http"
  require "uri"

  def cullArticles(articlesArray)
    arrayLength = articlesArray.count
    puts arrayLength
    # want 4 headlines only
    # more or less
    # so skip (length div 4)
    skipNumber = (arrayLength / 4)
    if (skipNumber < 0) then 
      skipNumber = 0
    end
    puts skipNumber

    newArray = []
    countArticles = 0
    counter = 0
    until countArticles == 4 do
      aString = articlesArray[counter].to_s
      aString.gsub!("\n", "")

      truncatedString = ""
      for i in 0..3 do
        truncatedString = truncatedString + aString.split('.')[i].to_s + "."
      end
      # puts truncatedString
      newArray.push(truncatedString)
      countArticles = countArticles + 1
      counter = counter + skipNumber
    end
    newArray    
  
  end

  desc "scrape infoplease for news and sports"
  task :news => :environment do |t, args|

    require 'open-uri'
    require 'nokogiri'

    for year in 1946..2012 do
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

      # lets cull te number of news articles 
      if newsArray.length > 5 then
        newsArray = cullArticles(newsArray)
      end
      puts newsArray

      # MAY REVISIT THIS LATER
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

      # 
      news = NewsArticle.create(year: year, news: newsArray)
    end

    

  end

end