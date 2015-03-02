namespace :scrape_news do 
  require "net/http"
  require "uri"

  def cull_number_of_articles(articles_array)
    number_of_articles = articles_array.count

    # we want only 4 articles, must skip some
    number_of_articles_to_skip = (number_of_articles / 4)

    small_array_of_articles = []
    next_article_index = 0

    (0..4).each do
      this_article = articles_array[next_article_index].to_s
      this_article = clean_article(this_article)

      if this_article.length > 100 then
        # after 2008 articles get really long. Need to trim them
        truncated_article = truncate_article(this_article)
        small_array_of_articles << truncated_article
      else
        small_array_of_articles << this_article
      end

      next_article_index = next_article_index + number_of_articles_to_skip
    end
    small_array_of_articles
  end

  def clean_article(article)
    article.gsub!("\r\n", " ")
    article.gsub!(" . ", "")
    article
  end

  def truncate_article(article)
    truncate_finished = false
    sentence_counter = 0
    truncated_article = ""
    article_sentences = article.split('.')
    
    while not truncate_finished do
      truncated_article = truncated_article + article_sentences[sentence_counter].to_s + "."
      
      next_sentence = article_sentences[sentence_counter + 1]

      while next_sentence && check_if_connected(next_sentence) do  
        truncated_article = truncated_article + next_sentence + "."
        sentence_counter = sentence_counter + 1
        next_sentence = article_sentences[sentence_counter + 1]
      end

      if truncated_article.length > 100 then
        truncate_finished = true
      else
        sentence_counter = sentence_counter + 1
      end

    end
    truncated_article
  end

  def check_if_connected(sentence)
    first_character = sentence[0]
    second_character = sentence[1]
    if (first_character != (" " || "\r")  || (is_number(second_character)))
      return true
    else
      return false
    end
  end

  def is_number(character)
    character.to_i.to_s == character
  end

  desc "scrape infoplease for news and sports"
  task :news => :environment do |t, args|
    require 'open-uri'
    require 'nokogiri'

    for year in 2013..2015 do
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
      list_of_news_articles = html_doc.css(data_news)
      
      array_of_news_articles = [];
      for item in list_of_news_articles
        array_of_news_articles << item.text
      end

      # lets cull te number of news articles 
      if array_of_news_articles.length > 4 then
        array_of_news_articles = cull_number_of_articles(array_of_news_articles)
      end
      # puts array_of_news_articles

      news = NewsArticle.create(year: year, news: array_of_news_articles)
      puts news.inspect
    end

    

  end

end