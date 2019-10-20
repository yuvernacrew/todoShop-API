Rails.application.routes.draw do
  devise_for :user, only: []

  namespace 'api' do
    namespace :v1, defaults: { format: :json } do
      resource :login, only: [:create], controller: :sessions
      resource :users, only: [:create]
      resource :posts
      resource :rewards
    end
  end
end