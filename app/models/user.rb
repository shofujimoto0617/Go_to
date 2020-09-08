class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # refielのためのattachment
  attachment :image, destroy: false

  # バリデーション/エラーにする条件
  validates :user_name, presence: true, length: {maximum: 10, minimum: 2}
  validates :account_name, length: {maximum: 20}
  validates :introduction, length: {maximum: 50}
end
