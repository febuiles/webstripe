Ov::Application.routes.draw do
  devise_for :users, :controllers => { passwords: "passwords", sessions: "sessions" }
  get "/bienhecho", to: "stripes#show", :id => 28
  get '/:id' => 'stripes#show', :constraints => {:id => /\d+/}

  resources :stripes
  get "/admin", to: "admin::stripes#index"

  namespace :admin do
    resources :stripes
    resources :stripe_items
    resources :users
    post "/invite", to: "users#invite", as: :invite_user
    get "/reports/xls", to: "reports#xls", as: :xls_report
  end

  root :to => "pages#index"

  match "/terms", :to => "static#terms"
  match "/help", :to => "static#help"
end
