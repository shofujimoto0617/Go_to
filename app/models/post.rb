class Post < ApplicationRecord
  # userの関連付け
  belongs_to :user
  # post_imageの関連付け
  has_many :post_images, dependent: :destroy
  # post_commntの関連付け
  has_many :post_comments, dependent: :destroy
  # favoriteの関連付け
  has_many :favorites, dependent: :destroy
  # tag_mapsの関連付け
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps

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

  def save_tags(savepost_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - savepost_tags
    new_tags = savepost_tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name: old_name)
    end

    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(tag_name: new_name)
      self.tags << post_tag
    end
  end


end
