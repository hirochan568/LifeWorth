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
   get '/users/:id/my_page', to: 'users#show', as: 'my_page'
   get '/users/people', to: 'users#people'

  resources :blogs do
    resources :blog_comments, only: [:create, :destroy]
  end
  get '/blogs/:id/details', to: 'blogs#details', as: 'blog_details'

  resources :reviews do
    resources :review_comments, only: [:create, :destroy]
  end
  get '/reviews/:id/details', to: 'reviews#details', as: 'review_details'


  resources :questions do
    resources :question_comments, only: [:create, :destroy]
  end
  get '/questions/:id/details', to: 'questions#details', as: 'question_details'


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
