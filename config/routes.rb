# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#show"
  devise_for :users, controllers: {
    sessions: "users/sessions",
  }
  devise_scope :user do
    get "/users/sign_in/otp" => "users/otp/sessions#new"
    post "/users/sign_in/otp" => "users/otp/sessions#create"
    get "/users/sign_in/recovery_code" => "users/recovery_code/sessions#new"
    post "/users/sign_in/recovery_code" => "users/recovery_code/sessions#create"
  end

  resource :dashboard, controller: :dashboard
  resource :two_factor_authentication do
    scope module: :two_factor_authentication do
      resource :confirmation
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
