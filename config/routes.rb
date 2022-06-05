Rails.application.routes.draw do
  root 'payment_requests#index'
  resources :payment_requests, only: %i[index] do
    post :accept
    post :reject
  end
end
