Rails.application.routes.draw do
  get '/', to: 'application#welcome'

  resources :merchants do
    resources :dashboard, only: [:index]
    resources :invoices, only: [:index, :show]
    resources :invoice_items, only: [:update]
    resources :items, exclude: [:destroy]
    resources :discounts, only: [:index, :show]
  end

  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants, except: [:destroy]
    resources :invoices, only: [:index, :show]
    resources :invoice_items, only: [:update]
  end
end
