Rails.application.routes.draw do
  resources :projects
  resources :organizations
  devise_for :users

  root 'projects#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
