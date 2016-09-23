require 'sidekiq/web'

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'user', controllers: {
    sessions: 'overrides/sessions'
  }

  namespace :api do
    namespace :v1 do
      resources :users, only: [:show] do
        scope module: :users do
          resources :reservations, only: [:index]
          collection do
            resource :profile_image, only: [:create, :update]
          end
        end
      end

      resources :services, only: [:index, :create, :show, :update] do
        post :publish
        post :unpublish

        collection do
          get :search
        end

        scope module: :services do
          resources :events, only: [:index] do
            collection do
              get :future
            end
          end
          resources :service_photos, only: [:index, :create, :update]
          resources :reservations, only: [:index]
        end
      end

      resources :events, only: [:create, :show, :update, :destroy]

      resources :reservations, only: [:create] do
        post :approve
        post :disapprove
        post :cancel_by_client
        post :cancel_by_service
      end

      resources :service_photos, only: [:destroy]
      resource :device, only: [:create, :destroy]
    end
  end

  namespace :admin do
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      username == SIDEKIQ_USERNAME && password == SIDEKIQ_PASSWORD
    end

    mount Sidekiq::Web => '/sidekiq'
  end
end
