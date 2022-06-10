require 'rails_helper'

RSpec.describe User, type: :model do
  the_user = User.new(
    name: 'Omid',
    photo: 'https://via.placeholder.com/150',
    bio: 'Some text as bio!',
    posts_counter: 0
  )

  context 'user.name' do
    it 'has some value' do
      the_user.name = nil
      expect(the_user).to_not be_valid
    end

    it 'is not blank' do
      the_user.name = '    '
      expect(the_user).to_not be_valid
    end

    it 'accepts "Omid"' do
      the_user.name = 'Omid'
      expect(the_user).to be_valid
    end
  end

  context 'user.posts_counter' do
    it 'has some value' do
      the_user.posts_counter = nil
      expect(the_user).to_not be_valid
    end

    it 'is integer' do
      the_user.posts_counter = 1.2
      expect(the_user).to_not be_valid
    end

    it 'accepts 0 and 10' do
      [0, 10].each do |counter|
        the_user.posts_counter = counter
        expect(the_user).to be_valid
      end
    end
  end

  context 'recent_3_posts method' do
    let(:the_author) { User.create!(name: 'Omid', photo: 'https://via.placeholder.com/150', bio: 'bio!', posts_counter: 0) }
    let(:post1) { Post.new(title: 'post 1', user: the_author, text: 't', comments_counter: 0, likes_counter: 0) }
    let(:post2) { Post.new(title: 'post 2', user: the_author, text: 't', comments_counter: 0, likes_counter: 0) }
    let(:post3) { Post.new(title: 'post 3', user: the_author, text: 't', comments_counter: 0, likes_counter: 0) }
    let(:post4) { Post.new(title: 'post 4', user: the_author, text: 't', comments_counter: 0, likes_counter: 0) }

    it 'returns nothing without any posts' do
      posts_count = the_author.recent_3_posts.count
      expect(posts_count).to be 0
    end

    it 'returns 1 for one post' do
      post1.save!
      posts_count = the_author.recent_3_posts.count
      expect(posts_count).to be 1
    end

    it 'returns 3 posts for more than 3 posts' do
      post2.save!
      post3.save!
      post4.save!

      posts = the_author.recent_3_posts
      posts_count = posts.count
      titles = posts.pluck(:title)

      expect(posts_count).to be 3
      expect(titles).to eq [post4.title, post3.title, post2.title]
    end
  end
end