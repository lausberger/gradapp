# frozen_string_literal: true

Rails.application.routes.draw do
  # Graduate Applications
  resources :graduate_applications
  resource :statics
  resources :messages
  resources :discussions
  patch 'withdraw_application' => 'graduate_applications#withdraw'

  # Home/Static Pages
  root to: redirect('/home')
  get 'home' => 'statics'
  get 'faq' => 'statics'

  # Discussions
  post 'discussions/create_reply'

  # Accounts
  get 'register', to: 'accounts#new'
  post 'register', to: 'accounts#create'
  get 'profile', to: 'accounts#show'

  # Messages
  get 'messages', to: 'messages#index'
  get 'messages/new', to: 'messages#new'
  post 'messages/send_message', to: 'messages#send_message'

  # Faculty Search
  resources :faculties
  post 'faculties/search', to: 'faculties#search'

  # consider adding separate 'sessions' controller for managing login sessions

  # https://www.section.io/engineering-education/how-to-setup-user-authentication-from-scratch-with-rails-6/
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
