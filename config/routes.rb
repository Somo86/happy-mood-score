Rails.application.routes.draw do
  namespace :main do
    resources :contacts, only: %i[new create]
    resources :dashboard, only: %i[index]
    resource :employee, only: %i[edit update]
    resources :feedback, only: %i[index]
    resources :high5, only: %i[index new create] do
      collection do
        post :search
      end
    end
    resources :notes
    resources :ranking, only: %i[show]
  end

  namespace :admin do
    resources :dashboard, only: %i[index]
    resources :feedback, only: %i[index update] do
      resources :replies, only: %i[create]
      resources :reminders, only: %i[create]
    end
    resources :high5, only: %i[index show new create] do
      collection do
        post :search
      end
    end
    resources :notes
    resources :polls do
      member do
        put :toggle
      end
    end
    resources :ranking, only: [] do
      collection do
        get 'teams'
        get 'employees'
      end
    end
    resources :trends, only: [] do
      collection do
        get 'global'
      end
    end

    # admin
    resources :employees do
      resource :permission, only: %i[update destroy]
      resource :archive, only: %i[update destroy]
      collection do
        post :search
      end
    end
    resources :teams
    resources :jobs, only: %i[create destroy]
    resources :companies, only: %i[show edit update destroy] do
      resources :deliveries, only: %i[index update]
      resource :slack, only: %i[show update destroy], controller: :slack
      resources :removes, only: %i[index destroy]
    end
    resources :uploads, only: %i[new create]

    # gamification
    resources :events
    resources :rules do
      resources :conditions
    end
    resources :rewards
    resources :activities, only: %i[index]
    resources :achievements, only: %i[index]
    resources :test_emails do
      collection do
        post :feedback_request
      end
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v3 do
      resource :company, only: %i[show]
      resources :high5, only: %i[index create], controller: :high5
      resources :feedback, only: %i[index create]
      resources :teams, except: %i[destroy]
      resources :employees, except: %i[destroy]
    end
    resource :slack, only: [], controller: :slack do
      collection do
        post :high5
        post :feedback
        post :report
        post '1on1', to: 'slack#one2one'
        get :auth
      end
    end
  end

  resources :companies, only: %i[new create]
  resources :user_sessions, only: %i[create]
  resources :password_resets, only: %i[new create edit update]
  resources :users do
    member do
      get :activate
    end
  end

  get 'polls/:company/:slug', to: 'poll_votes#new', as: :new_poll_vote
  post 'polls/:company/:slug', to: 'poll_votes#create', as: :poll_votes
  get 'vote/:id/:status', to: 'votes#new', as: :new_vote
  post 'votes', to: 'votes#create'
  post '/graphql', to: 'graphql#execute'
  get 'login' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout

  root to: 'companies#new'
end
