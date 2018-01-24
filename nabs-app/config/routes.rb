Rails.application.routes.draw do
  get 'home/index'
  resource :passwords
  devise_for :users, :path => 'u', controllers: { confirmations: 'confirmations', sessions: 'sessions' }
  resources :users do
    match "/reset_password", :to => "users#reset_password", :as => "reset_password", via: [:get, :post]
  end
  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
      resources :referrals, except: [:show]
      resources :clinics
      resources :requests
      get 'search', as: :doctors, controller: :doctors, action: :search
      post 'select_doctor/:id', as: :select_doctor, controller: :doctors, action: :select_doctor
      get 'referrals/:id/assign_patient', as: :assign_patient, controller: :referrals, action: :assign_patient
      patch 'referrals/:id/send_referral', as: :send_referral, controller: :referrals, action: :send_referral
      patch 'requests/:id/deny', as: :deny_requests, controller: :requests, action: :deny
      patch 'requests/:id/accept', as: :accept_requests, controller: :requests, action: :accept
    end
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
