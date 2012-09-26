Ov::Application.routes.draw do
  devise_for :users
  resources :stripes
  namespace :admin do
    resources :stripes
  end

  root :to => "pages#index"
end
