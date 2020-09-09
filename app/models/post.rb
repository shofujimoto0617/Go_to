class Post < ApplicationRecord
  # userとの関連付け
  belongs_to :user
  # post_imageの関連付け
  has_many :post_images, dependent: :destroy
  accepts_nested_attributes_for :post_images, allow_destroy: true

  enum cuntry:{
  	国内: 0,
  	海外: 1
  }
end
