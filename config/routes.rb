Educator::Application.routes.draw do

  

  #  match '/login'=>'sessions#new', :as=> :login
  # match '/logout'=>'user_sessions#destroy', :as=> :logout
  #  match '/sessions'=>'sessions#create'
  
  devise_for :users, :path_names => { :sign_out => 'logout' }

  match 'contacts/invite' => 'contacts#invite'
  match 'contacts/import' => 'contacts#import'
  match '/contacts/find_friends' => 'contacts#find_friends'
  match '/users/examples' => 'users#examples'
  match '/employment_histories/examples' => 'employment_histories#examples'
  match '/archives/rules' => 'archives#rules'
  devise_for :users
  match '/education_histories/search' => 'education_histories#search'
  match '/employment_histories/search'=>'employment_histories#search'

  resources :users do

    member do
      
      match 'settings/account' => 'settings#account'
      match 'settings/privacy' => 'settings#privacy'
      match 'settings/blocklist' => 'settings#blocklist'
      match 'discussions/poll' => 'discussions#poll'
      match 'discussions/photo' => 'discussions#photo'
      match 'discussions/video' => 'discussions#video'
      match 'employment_histories/:id/add' => 'employment_histories#add'
      
    end
    resources :employers
    resources :employment_histories 

    match 'message_search/'=>'messages#message_search'
    match 'delete_messages'=>'messages#delete_messages'
    match 'requests/request_action'=>'requests#request_action'
    resources :education_histories

    resources :messages do
      member do
        match 'replies' =>'messages#replies'
      end
    end

    resources :requests

    match 'contacts/group' => 'contacts#group'
    
    resources :contacts 

    resources :discussions do
      resources :comments
    end
    resources :archives do
      resources :comments
    end
   
    resource :settings do
      collection do
        get :account, :privacy, :blocklist
        post :account_setting
      end
    end
  end

  
  match '/archives' => 'archives#all'
 
  match '/home' => 'dashboard#home'
  match '/users/:user_id/requests/:id/accept' => 'requests#accept'
  root :to => "dashboard#home"
  

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
