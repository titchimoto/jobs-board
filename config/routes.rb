Rails.application.routes.draw do

  resources :jobs do
    resources :favorites, only: [:create, :destroy]
  end


  devise_for :users
  get 'welcome/index'

  get 'welcome/about'

  root 'jobs#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
