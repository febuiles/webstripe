Ov::Application.routes.draw do
  devise_for :users
  resources :stripes

  root :to => "pages#index"
end
