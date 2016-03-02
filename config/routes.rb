Rails.application.routes.draw do
  
  devise_for :users
  
  get 'admin' => "admin/dashboard#index", :as => :admin_dashboard
  namespace :admin do
    match :confidence, :via => [:get,:post], :controller => 'confidence', :action => 'edit'
    resource :account
    resources :citations
    resources :datasets do
      match :compare, :on => :collection, :via => [:get,:post]
      get :delete, :on => :member
    end
    resources :events do
      post :batch, :on => :collection
      get :delete, :on => :member
    end
    resources :errors do
      get :import, :on => :collection
      post :import, :on => :collection
    end
    get "export/observations" => "exports#observations"
    get "export/species" => "exports#species"
    get "export/events" => "exports#events"
    resources :estimates do
      get :import, :on => :collection
      post :import, :on => :collection
    end
    resources :items do
      get :delete, :on => :member
    end
    resources :locations
    resources :models
    resources :methods
    resources :observations do
      get :curate, :on => :collection
      get :clear, :on => :collection
      get :curated, :on => :collection, :action => :curated_form
      post :curated, :on => :collection
      get :user, :on => :collection, :action => :user_form
      post :user, :on => :collection
      get :adjust, :on => :member
      get :delete, :on => :member
    end
    resources :pages do
      get :batch, :on => :collection
      get :delete, :on => :member
    end
    resources :processes
    resources :species do
      post :batch, :on => :collection
      get :delete, :on => :member
    end
    resources :taxonomies
    resource :password
    resources :users do
      get :reset, :on => :member
    end
  end

  match 'translate' => 'site#translate', :as => :translate, :via => [:get,:post]
  match 'predict' => 'site#predict', :as => :predict, :via => [:get,:post]
  match 'feedback' => 'site#feedback', :as => :feedback, :via => [:get,:post]
  get 'species' => 'site#species'
  get 'tables' => 'tables#index'
  get 'tables/abbreviations' => 'tables#abbreviations'
  get 'tables/empirical/:id' => 'tables#empirical'
  get 'tables/estimates/:id' => 'tables#estimates'
  get 'tables/events/:id' => 'tables#events'
  get ':permalink' => 'site#page', :as => :page
  root :to => "site#page", :permalink => 'home'

end