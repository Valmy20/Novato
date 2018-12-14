Rails.application.routes.draw do
  namespace 'backoffice', path: 'panel' do
    root 'admins#index'
    resources :admins, except: %i[show]
    match 'profile', to: 'admins#profile', via: %i[get patch put], as: :profile
    resources :categories, except: %i[show]
  end

  namespace 'frontend', path: 'novato' do
    resources :users, only: %i[show new create edit update destroy]
    match 'user_profile', to: 'users#profile', via: %i[get patch put], as: :user_profile
  end

  # home
  root 'frontend#index'

  # session admin
  get 'admin/login', to: 'sessions#new', as: :new_session
  post 'admin/login', to: 'sessions#create', as: :sessions
  get 'logout', to: 'sessions#destroy', as: :logout_session

  # session user
  get 'user/login', to: 'sessions_users#new', as: :new_session_user
  post 'user/login', to: 'sessions_users#create', as: :sessions_user
  get 'logout_user', to: 'sessions_users#destroy', as: :logout_session_user

  #reset admin password
  match 'reset_password', to: 'frontend/admins#reset_password', as: :reset_password, via:[:get, :post]
  get 'verify_token_reset/:token', to: 'frontend/admins#verify_token_reset', as: :verify_token_reset
end
