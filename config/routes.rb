Rails.application.routes.draw do
  # ↓デバイスにより生成
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
   end

  resources :users,only: [:index, :edit, :update]
   get '/users/my_page', to: 'users#show'
   get '/users/people', to: 'users#people'

  root 'homes#top'
  get 'home/about' => 'homes#about'
  # resources :books do
  #   resource :favorites, only: [:create, :destroy]
  #   resources :book_comments, only: [:create, :destroy]
  # end





#   namespace :users do
#     resources :posts
#   end
#   root 'users/posts#index'


end
