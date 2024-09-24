Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :projects do
  member do
    get "redirect_to_edit"
  end
  resources :bugs do
    patch :assign_bug_to_self, on: :member
    get :remove_developer, on: :member
end
end
resources :bugs, only: [ :index ]
  root to: "projects#index"
end
