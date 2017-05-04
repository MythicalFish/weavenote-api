Rails.application.routes.draw do
  root to: 'application#root'
  get 'stats', to: 'application#stats'

  # Projects
  resources :projects do
    resources :components
  end
  get '/projects/:id/get_upload_url', to: 'projects#get_upload_url'
  post '/projects/:id/create_image', to: 'projects#create_image'

end
