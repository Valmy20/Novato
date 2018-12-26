Rails.application.routes.draw do
  namespace 'backoffice', path: 'panel' do
    root 'admins#index'
    resources :admins, except: %i[show]
    match 'profile', to: 'admins#profile', via: %i[get patch put], as: :profile
    resources :categories, except: %i[show]
    resources :users, only: %i[index show]
    post 'update_user_status/:id', to: 'users#update_status', as: :update_user_status
  end

  namespace 'frontend', path: 'novato' do
    resources :users, only: %i[show new create edit update destroy]
    match 'user_profile', to: 'users#profile', via: %i[get patch put], as: :user_profile
    match 'update_user_cover', to: 'users#update_user_cover', via: %i[get patch put], as: :update_user_cover
    match 'update_user_password', to: 'users#update_user_password', via: %i[get patch put], as: :update_user_password
  end

  namespace 'company', path: 'novato' do
    resources :employers, only: %i[new create edit update destroy]
    resources :publications
    match 'job_location/:id', to: 'publications#location', via: %i[get patch put], as: :job_location
    match 'employer_profile', to: 'employers#profile', via: %i[get patch put], as: :employer_profile
    match 'update_employer_password', to: 'employers#update_employer_password', via: %i[get patch put], as: :update_employer_password
    match 'location', to: 'employers#location', via: %i[get patch put], as: :employer_location
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

  # session employer
  get 'employer/login', to: 'sessions_employers#new', as: :new_session_employer
  post 'employer/login', to: 'sessions_employers#create', as: :sessions_employer
  get 'logout_employer', to: 'sessions_employers#destroy', as: :logout_session_employer

  #reset admin password
  match 'reset_password', to: 'frontend/admins#reset_password', as: :reset_password, via:[:get, :post]
  get 'verify_token_reset/:token', to: 'frontend/admins#verify_token_reset', as: :verify_token_reset

  #reset user password
  match 'user_reset_password', to: 'frontend/users#reset_password', as: :user_reset_password, via:[:get, :post]
  get 'user_verify_token_reset/:token', to: 'frontend/users#verify_token_reset', as: :user_verify_token_reset

  #reset employer password
  match 'employer_reset_password', to: 'company/employers#reset_password', as: :employer_reset_password, via:[:get, :post]
  get 'employer_verify_token_reset/:token', to: 'company/employers#verify_token_reset', as: :employer_verify_token_reset

  #user login facebook
  post 'login/:provider', to: redirect('/auth/%{provider}'), as: :login_facebook
  get 'auth/:provider/callback', to: 'sessions_users#create', as: :login_with_provider
  mount Ckeditor::Engine => '/ckeditor'
end
