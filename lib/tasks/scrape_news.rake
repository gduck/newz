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
    whichArticle = 0
    until countArticles == 4 do
      aString = articlesArray[whichArticle].to_s
      aString.gsub!("\n", "")
      aString.gsub!("\r", "")

      if aString.length > 100 then
        # after 2008 articles get really long. Need to trim them
        finishTruncate = false
        sentenceCounter = 0
        truncatedString = ""
        while finishTruncate == false do
          truncatedString = truncatedString + aString.split('.')[sentenceCounter].to_s + "."

          # if no space after the "." then this is not a full stop
          # ie maybe a decimal point & we need the rest of the sentence
          # complicated, I know
          # if there is a space FOLLOWED BY A NUMBER then it's a date 
          # and we want to keep it together & not truncate yet
          puts ">>>>>>>>>> CHECKING FOR SPACE"
          nextSentence = aString.split('.')[sentenceCounter + 1]
          # puts nextSentence[1].to_i.to_s
          # puts (nextSentence[1].to_i.to_s == nextSentence[1])
          if (nextSentence) &&
            (nextSentence[0] != " " || (nextSentence[1].to_i.to_s == nextSentence[1])) then
            truncatedString = truncatedString + aString.split('.')[sentenceCounter + 1].to_s + "."
            sentenceCounter = sentenceCounter + 1
            puts ">>>>>>>>>>> DID TRICKY SENTENCE THING HERE"
          end
          if truncatedString.length > 100 then
            finishTruncate = true
          else
            sentenceCounter = sentenceCounter + 1
          end
        end
        puts ">>>>>>>>>>>>>>>>>MODIFIED"
        puts truncatedString
        puts truncatedString.length
        newArray.push(truncatedString)
      else
        puts ">>>>>>>>>>>>>>>>> NOT MODIFIED"
        puts aString
        newArray.push(aString)
      end

      countArticles = countArticles + 1
      whichArticle = whichArticle + skipNumber
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
      # puts newsArray

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
      puts news.inspect
    end

    

  end

end