Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :projects do
  member do
    get "redirect_to_edit"
  end
  resources :bugs
end
resources :bugs, only: [ :index ]
  root to: "projects#index"
end
