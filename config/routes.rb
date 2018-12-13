Rails.application.routes.draw do
  namespace 'backoffice', path: 'panel' do
    root 'admins#index'
    resources :admins, except: %i[show]
    match 'profile', to: 'admins#profile', via: %i[get patch put], as: :profile
    resources :categories, except: %i[show]
  end

  # session admin
  get 'admin/login', to: 'sessions#new', as: :new_session
  post 'admin/login', to: 'sessions#create', as: :sessions
  get 'logout', to: 'sessions#destroy', as: :logout_session

  #reset admin password
  match 'reset_password', to: 'frontend/admins#reset_password', as: :reset_password, via:[:get, :post]
  get 'verify_token_reset/:token', to: 'frontend/admins#verify_token_reset', as: :verify_token_reset
end
