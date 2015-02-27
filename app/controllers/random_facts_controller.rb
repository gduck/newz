class RandomFactsController < ApplicationController

  def find
    require 'nokogiri'

    dateArray = params[:date].split('-')
    @year = dateArray[0]
    @month = dateArray[1]
    @day = dateArray[2]

    url = "http://www.mybirthdayfacts.com/MBFService.asmx"

    theXml = '<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body><FetchFacts xmlns="http://www.mybirthdayfacts.com"><dayStr>18</dayStr><monthStr>7</monthStr><yearStr>1975</yearStr></FetchFacts></soap:Body></soap:Envelope>'
    
    response = post_xml(url, theXml)

    # part of the response to be parsed
    # <go>164.34</go><dj>852.97</dj><hp>38600</hp><cr>5396</cr><br>0.35</br><gs>0.57</gs><wp>4,108,166,111</wp>
    # <br> tag messes with the nokogiri css search, lets replace it
    response.gsub! '<br>', '<bread>'
    response.gsub! '</br>', '</bread>'

    xml_doc = Nokogiri::HTML(response)
    puts xml_doc

    data_gold = "go"
    @gold = xml_doc.css(data_gold).text

    data_dowjones = "dj"
    @dowjones = xml_doc.css(data_dowjones).text

    data_homeprice = "hp"
    @homeprice = xml_doc.css(data_homeprice).text

    data_newcar = "cr"
    @newcar = xml_doc.css(data_newcar).text

    data_bread = "bread"
    @bread = xml_doc.css(data_bread).text

    data_gas = "gs"
    @gas = xml_doc.css(data_gas).text

    data_pop = "wp"
    @population = xml_doc.css(data_pop).text

    puts @gold + @dowjones
     # + homeprice + newcar + bread + gas + population
  
    render 'find.json.jbuilder'
  end

  def post_xml(path, xml)
    host = "http://www.mybirthdayfacts.com"
    http = Net::HTTP.new(host)
    resp = http.post(path, xml, { 'Content-Type' => 'text/xml; charset=utf-8' })
    return resp.body
  end

end
