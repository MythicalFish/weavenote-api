Rails.application.routes.draw do
  root to: 'application#root'
  resources :projects
  get 'stats', to: 'application#stats'
end
