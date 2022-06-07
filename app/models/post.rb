class Post < ApplicationRecord
  belongs_to :author, class_name: 'User',
                      foreign_key: 'author_id',
                      counter_cache: :posts_counter
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_save :update_posts_count

  def most_recent_five_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_posts_count
    author.update(posts_counter: author.posts.size)
  end
end
