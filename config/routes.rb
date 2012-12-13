Matrix::Application.routes.draw do
  resources :results

  get "exportxls/export"
  get "exportxls/exportresults"
  
  get "algorithm/calculation"  
  post "algorithm/calculation"  
  get "algorithm/calculate"
  get "groups/sidebartab"
  get "matrix_params/del"
  get "matrix_values/del"
  get "limit_pairs/del"
  post "limit_pairs/destroy"
  post "matrix_values/destroy"
  post "matrix_params/destroy"
  post "algorithm/addrecords"
  get "groups/a"
  post  "algorithm/index"
  post "algorithm/saveCoverage"
  post "matrix_values/update"
  
  post "matrix_params/import"
#  post "matrix_params/importParams"
#  get "matrix_params/exportJson"
#  post "matrix_params/upload"
  get "matrix_params/export"
  #post "matrix_params/index"
  get "algorithm/index"
  resources :group_values
  resources :limit_pairs
  resources :matrix_values

  resources :group_parameters

  resources :matrix_params

  resources :matrix_configs

  resources :groups
  

  resources :users do
   resources :groups do
     resources :matrix_configs
   end
  end

  get "login/login"

  get "login/index"

  resources :values

  resources :parameters do
    resources :values
  end



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'login#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
