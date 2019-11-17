class ApplicationController < ActionController::API
  # TODO: 何を継承してるのかさっぱりわからん。AbstractControllerって何.
  include AbstractController::Translation

  #アクション毎に実行するメソッド
  before_action :authenticate_user_from_token!

  # リクエストをjson形式に指定
  respond_to :json

  
  # ユーザー認証 (OAuth2)
  def authenticate_user_from_token!
    auth_token = request.headers['Authorization']

    if auth_token
      authenticate_with_auth_token auth_token
    else
      authenticate_error
    end
  end

  private

  # auth_tokenによるユーザーの照らし合わせ
  # access_tokenの形式 : "#{self.id}:#{Devise.friendly_token}"
  def authenticate_with_auth_token auth_token
    unless auth_token.include?(':')
      authenticate_error
      return
    end

    user_id = auth_token.split(':').first
    user = User.where(id: user_id).first

    if user && Devise.secure_compare(user.access_token, auth_token)
      # User can access
      sign_in user, store: false
    else
      authenticate_error
    end
  end

  # エラーの際に返すjson
  def authenticate_error
    render json: { error: t('認証エラー') }, status: 401
  end
end