Rails.application.routes.draw do
<<<<<<< HEAD
=======
  resources :discussions

  post 'discussions/create_reply'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
>>>>>>> 1170142366f6b6d1c5d25ae1286badf532bc68a3

  resource :statics
  root :to => redirect('/home')
  get 'home' => 'statics'
  get 'faq' => 'statics'

  get 'register', to: 'accounts#new'
  post 'register', to: 'accounts#create'

  # consider adding separate 'sessions' controller for managing login sessions
  # https://www.section.io/engineering-education/how-to-setup-user-authentication-from-scratch-with-rails-6/
  # get 'login', to: 'accounts#login'
  # post 'login', to: 'accounts#authenticate'
  # delete 'logout', to: 'accounts#logout'

end