Rails.application.routes.draw do
  mount Listings::Engine => "/listings"

  resources :projects
  resources :organizations, except: [:new]
  devise_for :users, :controllers => {:registrations => "registrations"}

  get "ods/:goal", to: 'sustainable_development_goals#detail', as: 'goal'
  get "proyectos", to: 'projects#public', as: 'public_projects'

  root 'projects#dashboard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
