Wattball::Application.routes.draw do
  resources :carousels

  resources :competitions

  resources :blogs

  resources :tickets

  match 'tickets/buy/:event' => 'tickets#new', :as => :buy_ticket

  resources :venues

  resources :sport_centers, :except => [:index]
  # This is really a hack
  match "about" => "sport_centers#show", :id => 1
  match "sport_centers" => "sport_centers#show", :id => 1


  resources :hurdle_matches, :only => [:index, :show]

  resources :scores

  resources :wattball_matches, :only => [:index, :show] do
    resources :scores, :only => [:index, :new]
  end

  match "contact" => "sport_centers#contact", :as => :sport_center, :via => "get"

  resources :events
  match 'calendar/(:date)' => 'events#index', :as => :events

  resources :tournaments

  resources :sports

  resources :officials

  resources :teams do

    collection do
      get 'results'
    end
  end

  resources :wattball_players
  resources :hurdle_players

  resources :staffs
  devise_for :users, :controllers => { :registrations => 'registrations' }

  get 'users', :to => 'home#index'

  get 'admin_panel', :to => 'panels#admin'
  get 'official_panel', :to => 'panels#official'
  get 'user_panel', :to => 'panels#user'

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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
