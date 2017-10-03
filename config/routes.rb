Rails.application.routes.draw do
  
  root to: 'application#root'
  
  resources :organizations, except: [:index]
  resources :materials
  resources :suppliers
  resources :comments
  resources :images, except: [:index]
  resources :invites
  resources :roles, except: [:create]
  resources :annotations, except: [:index, :show]
  
  resources :projects do
    get '/export', to: 'spec_sheet#create'
    get '/material_cost', to: 'projects#material_cost'
    get '/material_cost', to: 'projects#material_cost'
    get '/measurements', to: 'measurements#index'
    patch '/measurements', to: 'measurements#update'
    post '/measurement_groups', to: 'measurements#create_group'
    delete '/measurement_groups', to: 'measurements#delete_group'
    post '/measurement_names', to: 'measurements#create_name'
    delete '/measurement_names', to: 'measurements#delete_name'
    resources :components
    resources :instructions do
      post '/images', to: 'instructions#create_image'
      delete '/images/:id', to: 'instructions#destroy_image'
    end
  end

  # Misc:

  get '/s3_url', to: 'images#s3_url'
  post '/accept_invite/:id', to: 'invites#accept'
  get '/switch_organization', to: 'organizations#switch_organization'
  get '/user', to: 'users#show'
  patch '/user', to: 'users#update'
  get '/reset_password', to: 'users#reset_password'
  get '/stats', to: 'organizations#stats'
  
  # Static resources:
  
  get '/global_data', to: 'application#global_data'
  
  # PDF test page:
  
  get '/test', to: 'spec_sheet#test'

end
