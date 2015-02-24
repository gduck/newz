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

  desc "scrape wiki using the gem wikipedia-client"
  task :wikiclient => :environment do

    require 'wikipedia'
    dayStr = "18"
    monthStr = "July"
    yearStr = "1975"
    page = Wikipedia.find(monthStr + " " + yearStr)

    puts page.content
  end

  # australian newspaper
  # http://trove.nla.gov.au/newspaper/result?q&dateFrom=1975-07-18&dateTo=1975-07-18

  desc "scrape trove for news articles"
  task :trove => :environment do

    require 'open-uri'
    require 'nokogiri'

    dayStr = "18"
    monthStr = "07"
    monthStr = "July"
    yearStr = "1975"
    baseUrl = "http://trove.nla.gov.au"
    url = baseUrl + "/newspaper/result?q&l-word=100+-+1000+Words&dateFrom="+yearStr+"-"+monthStr+"-"+dayStr+"&dateTo="+yearStr+"-"+monthStr+"-"+dayStr

    begin
      document = open(url).read
      html_doc = Nokogiri::HTML(document)
      puts html_doc.css('title')
    rescue OpenURI::HTTPError => ex
      puts "Missing URL"
      return
    end

    data_article_link = "li.article > dl > dt > a"
    article_link = html_doc.css(data_article_link)
    for link in article_link do
      puts link.text
      newHref = link.attr("href").gsub("|||", "&")
      puts newHref
      # do some selection of the article here
      # if 'interesting' (page 1 article?) then scrape it
      scrapeArticle(baseUrl + newHref)
    end
    # puts article
  end

  def scrapeArticle(url)
    begin
      document = open(url).read
      html_doc = Nokogiri::HTML(document)
    rescue OpenURI::HTTPError => ex
      puts "Missing category URL in scrapeArticle"
      return
    end
    puts "here in " + url
    data_article = "p.S8 > span"
    article = html_doc.css(data_article)
    lineNum = 0
    while (lineNum < 10) do
      puts article[lineNum].text
      lineNum+=1
    end

    # puts article.inspect
    puts ">>>>>>>>>>>>>>>>>"
  end

  desc "scrape wiki for articles"
  task :wiki => :environment do

    require 'open-uri'
    require 'nokogiri'
    require 'date'
    
    dayStr = "2"
    monthStr = "August"
    yearStr = "1990"
    url = "http://en.wikipedia.org/wiki/" + monthStr + "_" + yearStr
    

    begin
      document = open(url).read
      html_doc = Nokogiri::HTML(document)
      puts html_doc.css('title')
    rescue OpenURI::HTTPError => ex
      puts "Missing URL"
      return
    end
    

    # jquery
    # $("span#July_18\\.2C_1975_\\.28Friday\\.29").parent().next()

    article_links = [];
    aString = monthStr + "_" + dayStr
    article = html_doc.css("span[id*=#{aString}]").first.parent.next
    if article.next.name == "div" then
      puts "saving the picture from the div!"
      article = article.next.next
      puts "article next is " + article.to_s
    end

    article.next.children.each do |child|
      if (child.text != "\n") then
        article_links.push child.text
        # TODO must remove wiki reference links [xx] with regex
      end
    end
  
    puts article_links
    number_articles = article_links.count
    puts "number of article links " + number_articles.to_s


  end


end
