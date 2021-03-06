Rails.application.routes.draw do

  root 'searches#index'

  ##OAUTH paths
  get 'auth/:provider/callback', to: 'sessions#createauth'
  get 'auth/failure', to: redirect('/')

  resources :users

  match 'users/show', to: 'users#show', via: :show
  match 'add_friend', to: 'users#add_friend', via: :get
  match 'verify_add_friend', to:'users#verify_add_friend', via: :post
  match 'update_country', to: 'users#update_country', via: :post


  ##Sessions: login, create
  match '/login', to: 'sessions#new', via: :get
  match '/login_create', to: 'sessions#create', via: :post
  match '/logout', to: 'sessions#destroy', via: :delete

  ###Viewing other peoples searches, or their searches, and saving them
  match '/go_to_search', to: 'users#go_to_search', via: :post
  match '/users/save_topic', to: 'users#save_topic', via: :post

  resources :searches

  match '/searches_create', to: 'searches#create', via: :post
  match '/searches', to: 'searches#index', via: :get
  match '/searches_save_topic', to: 'searches#save_topic', via: :post
  match '/searches_display', to: 'searches#display', via: :get
  
  #post 'users/home', to: 'users#home'
  # match 'users/home', to: 'users#home', via: :show


  #

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
end
