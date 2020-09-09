class PostImage < ApplicationRecord
  # postの関連付け
  belongs_to :post, inverse_of: :post_images

  # mount_uploaders :post_image, PostImageUploader
end
