Draftfu::Application.routes.draw do

  get "draft/league/:league_id" => "draft#league", as: :league_draft

  match "draft/team/:league_id" => "draft#team", as: :team_draft
  
  match "draft/player" => "draft#player", via: :post

  get "home/index"
  get "home/import"

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  
  resources :users
  resources :sessions

  resources :leagues do
    get 'draftboard', on: :member
    get 'draft', on: :member
    resources :teams do
      get 'draft', on: :member
    end
  end
  resources :players
  
  root :to => "home#index"

  namespace :api do
    get "players" => "players#index", as: :api_players
    get "players/available"
    get "players/drafted"
    post "players/draft"
    get "leagues/current_pick" => "leagues#current_pick"
    get "leagues/start_draft" => "leagues#start_draft"
    get "leagues/picks_queue" => "leagues#picks_queue"
    post "leagues/missed_pick" => "leagues#missed_pick"
    get "teams/draft_picks" => "teams#draft_picks"
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
