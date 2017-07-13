Rails.application.routes.draw do
  
  root to: 'application#root'

  get '/user', to: 'users#show'
  patch '/user', to: 'users#update'
  get '/reset_password', to: 'users#reset_password'

  resources :organizations, only: [:create, :update, :destroy]
  get '/switch_organization', to: 'organizations#switch_organization'
  
  resources :materials
  resources :suppliers

  get '/material_types', to: 'static_resources#material_types'
  get '/colors', to: 'static_resources#colors'
  get '/currencies', to: 'static_resources#currencies'
  get '/care_labels', to: 'static_resources#care_labels'
  get '/role_types', to: 'static_resources#role_types'

  resources :images
  get '/s3_url', to: 'images#s3_url'
  
  resources :invites
  post '/accept_invite/:id', to: 'invites#accept'
  resources :roles, only: [:index, :update, :destroy]
  
  resources :projects do
    get '/measurements', to: 'measurements#index'
    patch '/measurements', to: 'measurements#update'
    post '/measurement_groups', to: 'measurements#create_group'
    post '/measurement_names', to: 'measurements#create_name'
    resources :components
    resources :instructions do
      post '/images', to: 'instructions#create_image'
      delete '/images/:id', to: 'instructions#destroy_image'
    end
  end

  get 'stats', to: 'organizations#stats'

end
