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
    member do
      get 'draftboard'
      get 'draft'
      get 'team_draft'
      post 'setup_draft'
    end

    resources :teams do
      get 'draft', on: :member
      get 'draftboard', on: :member
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
    get "leagues/draft_info" => "leagues#draft_info"
    get "leagues/start_draft" => "leagues#start_draft"
    get "leagues/picks_queue" => "leagues#picks_queue"
    post "leagues/missed_pick" => "leagues#missed_pick"
    post "leagues/pause_draft" => "leagues#pause_draft"
    post "leagues/resume_draft" => "leagues#resume_draft"
    get "teams/draft_picks" => "teams#draft_picks"
  end
end
