class Post < ApplicationRecord
  # userの関連付け
  belongs_to :user
  # post_imageの関連付け
  has_many :post_images, dependent: :destroy
  # post_commntの関連付け
  has_many :post_comments, dependent: :destroy
  # favoriteの関連付け
  has_many :favorites, dependent: :destroy

  accepts_attachments_for :post_images, attachment: :image

  # cuntryの選択
  enum country:{
  	国内: 0,
  	海外: 1
  }

  #いいねを押しているか判断
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
