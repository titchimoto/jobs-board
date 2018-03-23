Rails.application.routes.draw do

  resources :jobs do
    resources :favorites, only: [:create, :destroy]
  end



  devise_for :users
  resources :users, only: [:show, :edit, :update]


  get 'welcome/index'

  get 'welcome/about'

  get 'profiles/show'

  root 'jobs#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
