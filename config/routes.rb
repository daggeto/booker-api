Rails.application.routes.draw do
  devise_for :users,
             controllers:
               {
                 sessions: 'api/v1/user/sessions',
                 registrations: 'api/v1/user/registrations',
                 passwords: 'api/v1/user/passwords'
               }


  namespace :api do
    namespace :v1 do
      resources :services, only: [:index, :show, :update] do
        scope module: :services do
          resources :events, only: [:index]
        end
      end

      resources :events, only: [:create, :show, :update, :destroy]
    end
  end
end
