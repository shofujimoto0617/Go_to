class Tag < ApplicationRecord
  # tag_mapの関連付け
  has_many :tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  # postの関連付け
  has_many :post, through: :tag_maps
end
