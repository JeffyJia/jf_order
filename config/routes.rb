Rails.application.routes.draw do
  root "home#index"

  resource :wechat, only: %i( show create )
  namespace :wechat do
    resources :stores, only: %i( index show )
    resource :cart, only: :destroy do
      collection do
        post :add, path: 'add/:id'
        delete :minus, path: 'minus/:id'
      end
    end
    resources :users, only: %i( show )
    resources :orders, only: %i( new index show create destroy )
    resources :addresses
    resource :payment, only: %i( new create show) do
      get :done
      post :notify
    end
  end
  get 'auth/wechat/callback', to: 'home#wechat'

  devise_for :users, :controllers => {
      :omniauth_callbacks => "users/omniauth_callbacks",
  }

  resources :users, except: %i( new create ) do
    member do
      patch :rolify
    end
  end
  resources :menus do
    member do
      get 'pictures', to: 'menus#list'
      post 'pictures', to: 'menus#upload'
      delete 'pictures/:picture_id', to: 'menus#remove'

      post :publish
      post :unpublish
    end
  end
  resources :locations
  resources :stores
  resources :orders do
    member do
      post :confirm
    end
  end

  require 'sidekiq/web'
  authenticate :user, lambda {|u| u.admin?} do
    mount Sidekiq::Web => '/sidekiq'
  end

end
