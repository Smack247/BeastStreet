Rails.application.routes.draw do

  devise_for :users
  resources :posts do
  	member do
  		get "like", to: "posts#upvote"
  		get "dislike", to: "posts#downvote"
  	end
  	resources :comments
  end
  root'posts#index'

  #Make the template + def index inside of Post Controller this is wear the index of the application is routed to
end
