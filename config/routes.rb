Rails.application.routes.draw do
  root to: "home#sign_in"

  match "/auth/:provider/callback" => "sessions#create", via: [:get, :post]
  match "/signout" => "sessions#destroy", :as => :signout, via: [:delete]
  match "/auth/failure" => "home#sign_in", via: [:get, :post]

  match "/contacts/:visit_id/:hosting_id" => "contacts#create", via: [:post]

  get 'privacy_policy', to: 'policies#facebook'

  resource :contacts, only: [:create]

  resources :visits, only: [:create, :destroy, :update, :show, :edit]

  resources :hostings, only: [:create, :destroy, :edit, :update]

  resources :users, only: [:edit, :show, :update, :destroy] do
    member do
      get :confirm_email
      get :unsubscribe
      delete :do_unsubscribe
    end

    resources :visits, only: [:new]
    resources :hostings, only: [:new]
  end

  get "/pages/:page" => "pages#show"
  get "five_hundred" => "home#five_hundred"
end
