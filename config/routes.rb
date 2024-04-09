Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  get 'home/about' => 'homes#about', as: 'about'
  resources :users, only: [:index, :create, :show, :edit, :update] do
    resources :relationships, only: [:create, :destroy]
      get 'followings', on: :member
      get 'follower', on: :member
  end
  resources :books, only: [:index, :show, :create, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, pnly: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
