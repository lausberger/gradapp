# frozen_string_literal: true

Rails.application.routes.draw do
  # Graduate Applications
  resources :graduate_applications
  resources :statics
  resources :messages
  resources :discussions

  # Home/Static Pages
  root to: redirect('/home')
  get 'home' => 'statics'
  get 'faq' => 'statics'

  # Discussions
  post 'discussions/create_reply'

  # Accounts
  get 'register', to: 'accounts#new'
  post 'register', to: 'accounts#create'

  # Messages
  get 'messages', to: 'messages#index'
  get 'messages/new', to: 'messages#new'
  post 'messages/send_message', to: 'messages#send_message'

  # consider adding separate 'sessions' controller for managing login sessions
  # https://www.section.io/engineering-education/how-to-setup-user-authentication-from-scratch-with-rails-6/
  # get 'login', to: 'accounts#login'
  # post 'login', to: 'accounts#authenticate'
  # delete 'logout', to: 'accounts#logout'
end
