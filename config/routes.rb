Ov::Application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :stripes
  end

  root :to => "pages#index"
end
