# frozen_string_literal: true

Rails.application.routes.draw do
  # Graduate Applications
  resources :graduate_applications
  resource :statics
  resources :messages
  resources :discussions
  patch 'withdraw_application' => 'graduate_applications#withdraw'

  # Documents
  post 'document/download', to: 'documents#download'

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
  get 'messages/reply', to: 'messages#show'
  post 'messages/reply_message', to: 'messages#reply_message'

  # Faculty Search
  resources :faculties
  post 'faculties/search', to: 'faculties#search'

  # Approve Faculty Members
  resources :approve_faculties

  # Approve Applications
  resources :application_decisions

  # Application Evaluations
  resources :application_evaluations

  # Student Checklist
  resources :student_checklists
  # get 'checklist/:id', to: 'student_checklists#show'
  # post 'checklist', to: 'student_checklists#edit'

  # Login session
  # https://www.section.io/engineering-education/how-to-setup-user-authentication-from-scratch-with-rails-6/
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Research Areas
  resources :research_areas
end
