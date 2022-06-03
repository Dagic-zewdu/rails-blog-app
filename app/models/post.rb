class Post < ApplicationRecord
  has_one :user
  has_many :likes
  has_many :comments
end
