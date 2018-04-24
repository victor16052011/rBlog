Rails.application.routes.draw do
  resources :categories
  resources:articles do
    resources :coments, only: [:create, :destroy, :update]
  end
  devise_for :users
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/dashboard", to: "welcome#dashboard"
  put "/articles/:id/publicado", to: "articles#publicado"
end
