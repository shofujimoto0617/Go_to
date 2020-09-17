class Room < ApplicationRecord
  # messageの関連付け
  has_many :direct_messages, dependent: :destroy
  # entryの関連付け
  has_many :entries, dependent: :destroy
end
