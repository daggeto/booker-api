Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'user', controllers: {
    sessions: 'overrides/sessions'
  }

  namespace :api do
    namespace :v1 do
      resources :users, only: [:show]

      resources :services, only: [:index, :create, :show, :update] do
        scope module: :services do
          resources :events, only: [:index]
          resources :service_photos, only: [:index, :create, :update]
        end
      end

      resources :events, only: [:create, :show, :update, :destroy] do
        post :book
        post :approve
        post :disapprove
      end

      resources :service_photos, only: [:destroy]
      resource :device, only: [:create, :destroy]
    end
  end
end
