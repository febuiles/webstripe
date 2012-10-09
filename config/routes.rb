Ov::Application.routes.draw do
  get '/:id' => 'stripes#show', :constraints => {:id => /\d+/}

  devise_for :users
  resources :stripes
  namespace :admin do
    resources :stripes
  end

  root :to => "pages#index"
end
