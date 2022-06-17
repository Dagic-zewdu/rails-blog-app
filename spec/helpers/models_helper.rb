def create_and_activate_user(name)
  user = User.create!(name:, email: "#{name}@example.com", password: '123456', bio: "Bio of #{name}",photo: "#{name}.jpg")
  user.save
  user.confirm
  user
end

def create_posts_for_user(user, count: 1)
  posts = []
  count.times do |i|
    posts << Post.create!(
      user:,
      title: "Post #{i}",
      text: "This is body of post #{i}",
      comments_counter: 0,
      likes_counter: 0
    )
  end
  posts
end

def create_comments_for_post_by_user(post, user, count: 1)
  comments = []
  count.times do |i|
    comments << Comment.create!(
      user:,
      post:,
      text: "Comment #{i}"
    )
  end
  comments
end
