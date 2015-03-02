class CardsController < ApplicationController

  def saveCard
    @card = Card.new(card_params)
    if @card.save
      render json: {success: true}
    else
      render json: @card.errors
    end  
  end  

  def new
    @card = Card.new()
    puts card_params
    puts "*************************"
    puts [:params]

  end


  private 
  def card_params
    params.require(:card).permit(:date, :image, :name, :feature_heading, :feature_article, :author)
  end 

end
