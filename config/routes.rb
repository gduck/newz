Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#index'
  get 'movies/:year' => 'movies#show'
  get 'songlists/:year' => 'songlists#show'
  get 'news/:year' => 'news_articles#show'

  get 'zodiac/:date' => 'zodiacs#find'
  get 'facts/:date' => 'random_facts#find'


end
