Rails.application.routes.draw do
  get 'users/role/:role', to: 'users#role'
  get 'current_user', to: 'current_user#index'
  get 'current_user/links', to: 'current_user#links'
  get 'current_user/open_conversation/:id' => 'current_user#open_conversation', as: :open_conversation
  post 'users/approve/:id' => 'users#approve', as: :approve_user
  post 'users/decline/:id' => 'users#decline', as: :decline_user
 

  resources 'conversations' do
    resources 'messages'
  end

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }, 
  defaults: { format: :json } 
  resources :current_user, :users, :uploads, :messages
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  
end
