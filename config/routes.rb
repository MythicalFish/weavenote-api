Rails.application.routes.draw do
  root to: 'application#root'
  get 'stats', to: 'application#stats'

  resources :materials, :material_types, :colors, :currencies, :care_labels, only: [:index]
  resources :suppliers

  get '/projects/:id/material_cost', to: 'projects#material_cost'
  get '/projects/:id/measurements', to: 'measurements#index'
  patch '/projects/:id/measurements', to: 'measurements#update'
  post '/projects/:id/measurement_groups', to: 'measurements#create_group'
  post '/projects/:id/measurement_names', to: 'measurements#create_name'
  resources :projects do
    get '/images/get_upload_url', to: 'images#get_upload_url'
    resources :images
    resources :components
    resources :instructions
  end

end
