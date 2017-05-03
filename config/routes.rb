Rails.application.routes.draw do
  resources :projects
  resources :organizations, except: [:new]
  devise_for :users

  get "ods/:goal", to: 'sustainable_development_goals#detail', as: 'goal'

  root 'projects#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
