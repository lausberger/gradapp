Rails.application.routes.draw do

  # AccountsController routes
  get 'register', to: 'accounts#new'
  post 'register', to: 'accounts#create'
  # consider adding separate 'sessions' controller for managing login sessions
  # https://www.section.io/engineering-education/how-to-setup-user-authentication-from-scratch-with-rails-6/
  # get 'login', to: 'accounts#login'
  # post 'login', to: 'accounts#authenticate'
  # delete 'logout', to: 'accounts#logout'
end
