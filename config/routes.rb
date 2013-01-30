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
      get :adjust, :on => :member
    end
    resources :pages do
      get :batch, :on => :collection
      get :delete, :on => :member
    end
    resources :processes
    resources :species do
      post :batch, :on => :collection
    end
    resources :taxonomies
    resource :password
    resources :users do
      get :reset, :on => :member
    end
  end

  match 'translate' => 'site#translate', :as => :translate
  match 'predict' => 'site#predict', :as => :predict
  match 'tables' => 'site#tables', :as => :tables
  match 'feedback' => 'site#feedback', :as => :feedback
  match ':permalink' => 'site#page', :as => :page
  root :to => "site#page", :permalink => 'home'

end