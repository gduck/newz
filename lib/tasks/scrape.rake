namespace :scrape do 
  require "net/http"
  require "uri"


  desc "scraping mybirthdayfacts.com"
  # must fill category table before doing this
  task :bdfacts => :environment do

    url = "http://www.mybirthdayfacts.com/MBFService.asmx"
    uri = URI.parse(url)

    theXml = '<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body><FetchFacts xmlns="http://www.mybirthdayfacts.com"><dayStr>18</dayStr><monthStr>7</monthStr><yearStr>1975</yearStr></FetchFacts></soap:Body></soap:Envelope>'
    # q = {
    #   dayStr: "18",
    #   monthStr: "7",
    #   yearStr: "1975",
    #   getCountry: "0"
    # }

    # Shortcut
    # response = Net::HTTP.post_form(uri, theXml)
    # puts response
    # puts post_xml(url, theXml)
    response = post_xml(url, theXml)
    puts response
  end

  def post_xml(path, xml)
    host = "http://www.mybirthdayfacts.com"
    http = Net::HTTP.new(host)
    resp = http.post(path, xml, { 'Content-Type' => 'text/xml; charset=utf-8' })
    return resp.body
  end

end



