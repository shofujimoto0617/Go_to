class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # bookの関連付け
  has_many :posts, dependent: :destroy

  # refielのためのattachment
  attachment :image, destroy: false

  # バリデーション/エラーにする条件
  validates :user_name, presence: true, length: {maximum: 10, minimum: 2}
  validates :account_name, length: {maximum: 20}
  validates :introduction, length: {maximum: 50}

  # sexカラムの選択内容
  enum sex:{
    男性: 0, 女性: 1
  }
end
