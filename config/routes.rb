Rails.application.routes.draw do
  devise_for :user, only: []

  namespace 'api' do
    namespace :v1, defaults: { format: :json } do
      resource :login, only: [:create], controller: :sessions
      resource :users, only: [:create]
      resources :posts do 
        # 全コレクションを対象にアクション追加
        collection do
          post 'complete'
        end
      end
      resources :rewards do
        collection do 
          post 'getReword'
        end
      end
    end
  end
end