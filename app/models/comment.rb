class Comment < ApplicationRecord
  has_one :post
  has_one :user
end
