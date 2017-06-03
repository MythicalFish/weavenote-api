Rails.application.routes.draw do
  root to: 'application#root'
  get 'stats', to: 'application#stats'

  resources :organizations, only: [:create, :update, :destroy]
  resources :materials
  resources :suppliers
  resources :material_types, :colors, :currencies, :care_labels, only: [:index]

  get '/s3_url', to: 'images#s3_url'

  resources :projects do
    get '/material_cost', to: 'projects#material_cost'
    get '/measurements', to: 'measurements#index'
    patch '/measurements', to: 'measurements#update'
    post '/measurement_groups', to: 'measurements#create_group'
    post '/measurement_names', to: 'measurements#create_name'
    get '/images', to: 'projects#images'
    post '/images', to: 'projects#create_image'
    delete '/images/:id', to: 'projects#destroy_image'
    resources :components
    resources :instructions do
      post '/images', to: 'instructions#create_image'
      delete '/images/:id', to: 'instructions#destroy_image'
    end
  end

  get '/user', to: 'users#show'

end
