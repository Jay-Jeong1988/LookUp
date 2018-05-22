Rails.application.routes.draw do

  get '/', to: 'targeting_idea#home'
  post '/', to: 'targeting_idea#search'

  get '/targeting_idea', to: 'targeting_idea#get'

  post '/targeting_idea', to: 'targeting_idea#search'

  get '/location', to: 'targeting_idea#set_location'
end
