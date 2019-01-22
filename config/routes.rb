Rails.application.routes.draw do
  namespace 'backoffice', path: 'panel' do
    root 'admins#index'
    resources :admins, except: %i[show]
    match 'profile', to: 'admins#profile', via: %i[get patch put], as: :profile
    resources :categories, except: %i[show]
    resources :users, only: %i[index show]
    resources :employers, only: %i[index show]
    resources :institutions, only: %i[index show]
    resources :messages, only: %i[index show destroy]
    resources :collaborators, only: %i[index show]
    resources :publications
    resources :posts
    post 'update_user_status/:id', to: 'users#update_status', as: :update_user_status
    post 'update_employer_status/:id', to: 'employers#update_status', as: :update_employer_status
    post 'update_institution_status/:id', to: 'institutions#update_status', as: :update_institution_status
    post 'update_collaborator_status/:id', to: 'collaborators#update_status', as: :update_collaborator_status
    match 'update_publication_status/:id', to: 'publications#update_status', via: %i[get patch put], as: :update_publication_status
    match 'update_post_status/:id', to: 'posts#update_status', via: %i[get patch put], as: :update_post_status
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

  namespace 'entity', path: 'novato' do
    resources :institutions, only: %i[new create edit update destroy]
    scope 'institution' do
      resources :publications
      match 'job_location/:id', to: 'publications#location', via: %i[get patch put], as: :job_location
    end
    match 'institution_profile', to: 'institutions#profile', via: %i[get patch put], as: :institution_profile
    match 'update_institution_password', to: 'institutions#update_password', via: %i[get patch put], as: :update_institution_password
    match 'update_institution_cover', to: 'institutions#update_institution_cover', via: %i[get patch put], as: :update_institution_cover
    match 'institution_location', to: 'institutions#location', via: %i[get patch put], as: :institution_location
  end

  namespace 'contributor', path: 'novato' do
    resources :collaborators, except: %i[index show update]
    match 'collaborator_profile', to: 'collaborators#profile', via: %i[get patch put], as: :collaborator_profile
    resources :posts, except: %i[show]
  end

  # home
  root 'frontend#index'
  get 'publications', to: 'frontend#search', as: :search_publications
  get 'show_publication/:publication', to: 'frontend#show_publication', as: :show_publication
  match 'new_message', to: 'frontend/messages#new_message', as: :new_message, via:[:get, :post]
  get 'list_posts', to: 'frontend#posts', as: :list_posts
  get 'show_post/:post', to: 'frontend#show_post', as: :show_post
  get 'show_profile_employer/:id', to: 'frontend#show_profile_employer', as: :show_profile_employer
  get 'show_profile_institution/:id', to: 'frontend#show_profile_institution', as: :show_profile_institution

  # compete
  post 'compete_publication/:id', to: 'frontend/competes#apply_publication', as: :apply_publication

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

  # session institution
  get 'institution/login', to: 'sessions_institutions#new', as: :new_session_institution
  post 'institution/login', to: 'sessions_institutions#create', as: :sessions_institution
  get 'logout_institution', to: 'sessions_institutions#destroy', as: :logout_session_institution

  # session collaborator
  get 'collaborator/login', to: 'sessions_collaborators#new', as: :new_session_collaborator
  post 'collaborator/login', to: 'sessions_collaborators#create', as: :sessions_collaborator
  get 'logout_collaborator', to: 'sessions_collaborators#destroy', as: :logout_session_collaborator

  #reset admin password
  match 'reset_password', to: 'frontend/admins#reset_password', as: :reset_password, via:[:get, :post]
  get 'verify_token_reset/:token', to: 'frontend/admins#verify_token_reset', as: :verify_token_reset

  #reset user password
  match 'user_reset_password', to: 'frontend/users#reset_password', as: :user_reset_password, via:[:get, :post]
  get 'user_verify_token_reset/:token', to: 'frontend/users#verify_token_reset', as: :user_verify_token_reset

  #reset employer password
  match 'employer_reset_password', to: 'company/employers#reset_password', as: :employer_reset_password, via:[:get, :post]
  get 'employer_verify_token_reset/:token', to: 'company/employers#verify_token_reset', as: :employer_verify_token_reset

  #reset institution password
  match 'institution_reset_password', to: 'frontend/institutions#reset_password', as: :institution_reset_password, via:[:get, :post]
  get 'institution_verify_token_reset/:token', to: 'frontend/institutions#verify_token_reset', as: :institution_verify_token_reset

  #user login facebook
  post 'login/:provider', to: redirect('/auth/%{provider}'), as: :login_facebook
  get 'auth/:provider/callback', to: 'sessions_users#create', as: :login_with_provider
  mount Ckeditor::Engine => '/ckeditor'
end
