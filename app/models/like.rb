class Like < ApplicationRecord
  belongs_to :author, class_name: 'User',
                      foreign_key: 'author_id'
  belongs_to :post, counter_cache: :likes_count

  after_save :update_likes_count

  private

  def update_likes_count
    post.update(likes_count: post.likes.size)
  end
end
