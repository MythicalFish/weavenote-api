Rails.application.routes.draw do
  root to: 'application#root'
  get 'stats', to: 'application#stats'

  resources :materials, :material_types, :colors, :currencies, :care_labels, only: [:index]
  resources :suppliers

  resources :projects do
    get '/material_cost', to: 'projects#material_cost'
    get '/measurements', to: 'measurements#index'
    patch '/measurements', to: 'measurements#update'
    post '/measurement_groups', to: 'measurements#create_group'
    post '/measurement_names', to: 'measurements#create_name'
    get '/images/get_upload_url', to: 'images#get_upload_url'
    resources :images
    resources :components
    resources :instructions
  end

end
