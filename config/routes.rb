Rails.application.routes.draw do
  resources :projects
  root to: 'application#root'
end
