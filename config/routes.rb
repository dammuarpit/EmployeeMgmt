Rails.application.routes.draw do


    devise_for :users, :controllers => {:registrations => "registrations", sessions: "sessions"}
                  #, :path_names => {:sign_in => 'login', :sign_out => 'logout'}
  resources :departments, :permission, :role, :user
  get 'home/home' => 'home#home', :as => 'home_page'
  get 'permissions/role_permission_mgmt' => 'permission#role_permission_mgmt', :as => 'role_pref_mgmt'
  post 'permissions/dynamic_mgmt' => 'permission#dynamic_mgmt', :as => 'role_pref_set'
  root 'home#home'

  mount MongodbLogger::Server.new, :at => "/mongodb"

  mount MongodbLogger::Assets.instance, :at => "/mongodb/assets", :as => :mongodb_assets # assets


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
