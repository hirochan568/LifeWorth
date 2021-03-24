Rails.application.routes.draw do
  # ↓デバイスにより生成
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords',
  }

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
   end

  resources :users,only: [:index, :edit, :update]
   get '/users/:id/my_page', to: 'users#show', as: 'my_page'
   get '/users/people', to: 'users#people'
   get '/users/message', to: 'users#message'
   get '/users/:id/blogs', to: 'blogs#show', as: 'user_blog'
   get '/users/:id/reviews', to: 'reviews#show', as: 'user_review'
   get '/users/:id/questions', to: 'questions#show', as: 'user_question'




  resources :blogs,only: [:index, :create, :edit, :update, :destroy, :new] do
    resource :blog_favorites, only: [:create, :destroy]
    resources :blog_comments, only: [:create, :destroy]
  end
  get '/blogs/:id/details', to: 'blogs#details', as: 'blog_details'
  get '/blogs/favorite', to: 'blogs#favorite', as: 'blogs_favorite'


  resources :reviews,only: [:index, :create, :edit, :update, :destroy, :new] do
    resource :review_favorites, only: [:create, :destroy]
    resources :review_comments, only: [:create, :destroy]
  end
  get '/reviews/:id/details', to: 'reviews#details', as: 'review_details'
  get '/reviews/favorite', to: 'reviews#favorite', as: 'reviews_favorite'

  resources :questions,only: [:index, :create, :edit, :update, :destroy, :new] do
    resource :question_favorites, only: [:create, :destroy]
    resources :question_comments, only: [:create, :destroy]
  end
  get '/questions/:id/details', to: 'questions#details', as: 'question_details'
  get '/questions/favorite', to: 'questions#favorite', as: 'questions_favorite'
  resources :messages, only: [:new, :create, :index, :destroy]


  root 'homes#top'
  get 'home/about' => 'homes#about'

  # ゲストユーザー作成用
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  # resources :books do
  #   resource :favorites, only: [:create, :destroy]
  #   resources :book_comments, only: [:create, :destroy]
  # end





#   namespace :users do
#     resources :posts
#   end
#   root 'users/posts#index'


end
