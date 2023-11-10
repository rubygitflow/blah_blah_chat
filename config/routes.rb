# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'chats#index'

  resources :chats do
    resources :posts, only: %i[new create destroy] do
      member { post :highlight }
    end
  end
  post 'chats/:id', controller: :chats, action: :show

  namespace :api do
    namespace :v1 do
      resources :chats, only: %i[index], shallow: true do
        resources :posts, only: %i[create]
      end
    end
  end

  match '*path', via: :all, to: redirect('/404')
end
