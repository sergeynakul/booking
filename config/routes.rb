Rails.application.routes.draw do
  root to: 'restaurants#index'

  resources :restaurants, shallow: true do
    resources :tables, shallow: true do
      resources :reservations
    end
  end
end
