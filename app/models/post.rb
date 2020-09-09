class Post < ApplicationRecord
  # userとの関連付け
  belongs_to :user
  # post_imageの関連付け
  has_many :post_images, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image

  # cuntryの選択
  enum country:{
  	国内: 0,
  	海外: 1
  }
end
