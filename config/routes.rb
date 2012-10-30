Ov::Application.routes.draw do
  devise_for :users
  get '/:id' => 'stripes#show', :constraints => {:id => /\d+/}


  resources :stripes

  namespace :admin do
    resources :stripes
  end

  root :to => "pages#index"
end
