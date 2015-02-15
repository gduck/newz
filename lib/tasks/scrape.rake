namespace :scrape do 
  require "net/http"
  require "uri"


  desc "scraping mybirthdayfacts.com"
  # must send by soap 
  task :bdfacts => :environment do

    url = "http://www.mybirthdayfacts.com/MBFService.asmx"

    theXml = '<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body><FetchFacts xmlns="http://www.mybirthdayfacts.com"><dayStr>18</dayStr><monthStr>7</monthStr><yearStr>1975</yearStr></FetchFacts></soap:Body></soap:Envelope>'
    
    response = post_xml(url, theXml)
    puts response
  end

  def post_xml(path, xml)
    host = "http://www.mybirthdayfacts.com"
    http = Net::HTTP.new(host)
    resp = http.post(path, xml, { 'Content-Type' => 'text/xml; charset=utf-8' })
    return resp.body
  end


  desc "scrape wiki for articles"
  task :wiki => :environment do

    require 'open-uri'
    require 'nokogiri'
    require 'date'
    
    dayStr = "18"
    monthStr = "July"
    yearStr = 1975
    url = "http://en.wikipedia.org/wiki/" + monthStr + "_" + yearStr
    

    begin
      document = open(url).read
      html_doc = Nokogiri::HTML(document)
    rescue OpenURI::HTTPError => ex
      puts "Missing URL"
      return
    end
    
    # might be trouble to independently find which day of the week
    # findDayOfWeek(dayStr, monthStr, yearStr);
    # data_article_link = monthStr + "_" + dayStr + ".2C_" + yearStr + "_.28" + dayOfWeek + ".29"
    data_href_link = "/wiki/" + monthStr + "_" + dayStr
    article_links = html_doc.css(data_pin_link)
    number_articles = article_links.count
    puts "number of article links " + number_articles.to_s

    # structure is
    # <h2><span> with id inc day of the week <a href with just month & day>
    #  then <ul> with articles directly under

  end


end
