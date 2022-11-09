Rails.application.routes.draw do

<<<<<<< HEAD
  # AccountsController routes
  get 'register', to: 'accounts#new'
  post 'register', to: 'accounts#create'
  # consider adding separate 'sessions' controller for managing login sessions
  # https://www.section.io/engineering-education/how-to-setup-user-authentication-from-scratch-with-rails-6/
  # get 'login', to: 'accounts#login'
  # post 'login', to: 'accounts#authenticate'
  # delete 'logout', to: 'accounts#logout'
=======
  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  resource :statics
  root :to => redirect('/home')
  get 'home' => 'statics'
  get 'faq' => 'statics'


  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
>>>>>>> e815e4ad0e68d8183c6c863cfd86fe9bd715abd0
end
