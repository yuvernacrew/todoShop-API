class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :rewords, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :recoverable, :rememberable, :trackable
  devise :database_authenticatable, :registerable, :validatable

  # DBへのコミット直前に実行
  after_create :update_access_token!

  # バリデート: emailは必ず書いてあること
  validates :email, presence: true

  def update_access_token!
    self.access_token = "#{self.id}:#{Devise.friendly_token}"
    save
  end
end
