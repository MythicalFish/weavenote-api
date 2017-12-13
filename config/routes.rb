# Use the ApiController when the subdomain is "api", or when the
# port number is 3001.
class ApiSubdomain
  def self.matches? request
    return true if request.subdomain === "api"
    return true if request.port == 3001
    return false
  end   
end

# Use the Application controller when the subdomain is "billing", 
# or when the port is 3002.
class BillingSubdomain
  def self.matches? request
    return true if request.subdomain === "billing"
    return true if request.port == 3002
    return false
  end   
end

Rails.application.routes.draw do
  
  mount Payola::Engine => '/payola', as: :payola

  constraints(ApiSubdomain) do

    root to: 'api#root'
    
    resources :organizations, only: [:create, :update, :destroy] 
    resources :materials, except: [:edit]
    post 'materials/:id', to: 'materials#duplicate'
    resources :comments, except: [:show, :edit, :new]
    post '/comments/parse_email', to: 'comments#parse_email'
    resources :images, except: [:index]
    resources :invites
    resources :roles, except: [:create]
    resources :annotations, except: [:show]
    
    resources :projects do
      get '/export', to: 'spec_sheet#create'
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
    post '/projects/:id', to: 'projects#duplicate'

    # Misc:

    get '/s3_url', to: 'images#s3_url'
    post '/accept_invite/:id', to: 'invites#accept'
    get '/switch_organization', to: 'organizations#switch_organization'
    get '/user', to: 'users#show'
    patch '/user', to: 'users#update'
    get '/reset_password', to: 'users#reset_password'
    get '/stats', to: 'organizations#stats'
    
    # Static resources:
    
    get '/global_data', to: 'api#global_data'
    
    # PDF test page:
    
    get '/test', to: 'spec_sheet#test'
    get '/test2', to: 'spec_sheet#test2'

  end

  constraints(BillingSubdomain) do
    root to: 'subscriptions#dashboard'
    resources :subscriptions
    patch '/subscriptions/:guid/reactivate', to: 'subscriptions#reactivate'
  end

end
