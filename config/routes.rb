Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts, except: :index
  resources :comments, only: [:create, :destroy, :update, :show]
end
