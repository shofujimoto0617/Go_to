Rails.application.routes.draw do
  devise_for :users
  get 'homes/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit, :update] do
  	member do
  		get :following, :followers
  	end
  end
  resources :posts do
  	resources :post_comments, only: [:create, :destroy]
  	resource :favorites, only: [:create, :destroy]
  end

  post 'follow/:id' => 'relationships#follow', as: 'follow'
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
end
