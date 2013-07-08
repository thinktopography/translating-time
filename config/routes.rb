Translatingtime::Application.routes.draw do
  
  devise_for :users do
    get "/users/sign_out", :to => "devise/sessions#destroy"
  end

  match 'admin' => "admin/dashboard#index", :as => :admin_dashboard
  namespace :admin do 
    resource :account
    resources :citations
    resources :events do
      post :batch, :on => :collection
      get :delete, :on => :member
    end
    resources :errors do
      get :import, :on => :collection
      post :import, :on => :collection
    end
    resources :estimates do
      get :import, :on => :collection
      post :import, :on => :collection
    end
    resources :items do
      get :delete, :on => :member
    end
    resources :locations
    resources :methods
    resources :observations do
      get :export, :on => :collection
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

  match 'translate' => 'site#translate', :as => :translate
  match 'predict' => 'site#predict', :as => :predict
  match 'species' => 'site#species'
  match 'tables' => 'tables#index'
  match 'tables/abbreviations' => 'tables#abbreviations'
  match 'tables/empirical/:id' => 'tables#empirical'
  match 'tables/estimates/:id' => 'tables#estimates'
  match 'tables/events/:id' => 'tables#events'
  match 'feedback' => 'site#feedback', :as => :feedback
  match ':permalink' => 'site#page', :as => :page
  root :to => "site#page", :permalink => 'home'

end