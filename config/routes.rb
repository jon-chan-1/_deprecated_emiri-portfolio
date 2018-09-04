Rails.application.routes.draw do
  get '/enter', to: 'sessions#new'
  post '/enter', to: 'sessions#create'
  delete '/exit', to: 'sessions#destroy'
  get '/pedalpal', to: 'content#pedalpal'
  get '/biovirtua', to: 'content#biovirtua'
  get '/epic', to: 'content#epic'
  get '/massage', to: 'content#massage'
  root 'content#index'
end
