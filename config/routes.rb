Rails.application.routes.draw do
  root to: 'application#root'
  resources :projects
  get '/projects/:id/get_upload_url', to: 'projects#get_upload_url'
  get 'stats', to: 'application#stats'
end
