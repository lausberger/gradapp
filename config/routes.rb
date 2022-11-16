Rails.application.routes.draw do
  # Graduate Applications
  resources :graduate_applications
  resource :statics

  # Home/Static Pages
  root :to => redirect('/home')
  get 'home' => 'statics'
  get 'faq' => 'statics'

  # Discussions
  resources :discussions
  post 'discussions/create_reply'

  # Accounts
  get 'register', to: 'accounts#new'
  post 'register', to: 'accounts#create'

  # Faculty Search
  resources :facultys
  post 'facultys/search', to: 'facultys#search'

  # consider adding separate 'sessions' controller for managing login sessions
  # https://www.section.io/engineering-education/how-to-setup-user-authentication-from-scratch-with-rails-6/
  # get 'login', to: 'accounts#login'
  # post 'login', to: 'accounts#authenticate'
  # delete 'logout', to: 'accounts#logout'

end
