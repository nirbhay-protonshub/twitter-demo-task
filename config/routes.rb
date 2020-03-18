Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  devise_for :users, skip: [:registrations, :sessions]
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      devise_for :users, controllers: { sessions: 'api/v1/sessions', registrations: 'api/v1/registrations' } 
    	
    	resources :tweets, only:[:create, :destroy, :index, :show] do
      	get :user_profile, on: :collection
      end

      get 'follow', to: 'relationships#follow_user'
      get 'unfollow', to: 'relationships#unfollow_user'
      get 'followers', to: 'relationships#user_followers'
      get 'followers_tweets', to: 'relationships#followers_tweets'
    end
  end
end
