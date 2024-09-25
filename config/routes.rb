Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :projects do
  member do
    get "redirect_to_edit"
  end
  resources :bugs do
    member do
      patch :assign_bug_to_self  # Assign bug to the current user (e.g., developer)
      get :remove_developer      # Remove the developer from the bug
    end

  collection do
    get "assigned", to: "bugs#assigned" # or whatever action you want to use
  end
end
end
resources :bugs, only: [ :index ] do
  collection do
    get "assigned", to: "bugs#assigned" # List all assigned bugs globally
  end
end
  root to: "projects#index"
end
