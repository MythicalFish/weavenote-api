Rails.application.routes.draw do
  root to: 'application#root'
  get 'stats', to: 'application#stats'

  resources :materials
  resources :material_types, only: [:index]
  resources :colors, only: [:index]

  get '/projects/:id/material_cost', to: 'projects#material_cost'
  resources :projects do
    get '/images/get_upload_url', to: 'images#get_upload_url'
    resources :images
    resources :components
  end

end
