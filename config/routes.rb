Rails.application.routes.draw do
  devise_for :users
   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :site do
    get 'welcome/index'
  end
  namespace :users_backoffice do
    get 'welcome/index'
  end
  namespace :admins_backoffice do
    get 'welcome/index' #Dashboard
    resources :admins #Administradores
  end
  devise_for :admins

  get 'inicio', to: 'site/welcome#index'

  root 'site/welcome#index'
end
