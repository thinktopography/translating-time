Translatingtime::Application.routes.draw do
  
  devise_for :users do
    get "/users/sign_out", :to => "devise/sessions#destroy"
  end

  match 'admin' => "admin/dashboard#index", :as => :admin_dashboard
  namespace :admin do 
    resources :citations
    resources :events
    resources :locations
    resources :methods
    resources :observations do
      get :curate, :on => :collection
    end
    resources :processes
    resources :species
    resources :taxonomies
    resources :passwords
    resources :users do
      get :reset, :on => :member
    end
  end

  root :to => "admin/dashboard#index"

end