Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  scope :api, defaults: { format: :json } do
    resources :products
    devise_for :users, controllers: { sessions: :sessions },
                       path_names: { sign_in: :login }
    resources :users, only: [:show, :update] do
      resources :addresses
    end
  end
end
