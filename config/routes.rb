Rails.application.routes.draw do
  root to: 'application#root'
  get 'stats', to: 'application#stats'

  # Projects
  resources :projects
  get '/projects/:id/get_upload_url', to: 'projects#get_upload_url'
  post '/projects/:id/add_image', to: 'projects#add_image'

end
