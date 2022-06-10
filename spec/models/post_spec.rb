require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:the_author) { User.create!(name: 'Omid', photo: 'https://via.placeholder.com/150', bio: 'Some text as bio!', posts_counter: 0) }
  let(:the_post) do
    Post.new(
      user: the_author,
      title: 'The post title', text: 'the body of the post',
      comments_counter: 0, likes_counter: 0
    )
  end
  let(:comment2) { Comment.new(user: the_author, post: the_post, text: 'c1') }
  let(:comment2) { Comment.new(user: the_author, post: the_post, text: 'c2') }
  let(:comment3) { Comment.new(user: the_author, post: the_post, text: 'c3') }
  let(:comment4) { Comment.new(user: the_author, post: the_post, text: 'c4') }
  let(:comment5) { Comment.new(user: the_author, post: the_post, text: 'c5') }
  let(:comment6) { Comment.new(user: the_author, post: the_post, text: 'c6') }

  context 'post.title' do
    it 'has some value' do
      the_post.title = nil
      expect(the_post).to_not be_valid
    end

    it 'is not blank' do
      the_post.title = '    '
      expect(the_post).to_not be_valid
    end

    it 'cannot be longer than 250 characters' do
      the_post.title = 'a' * 251
      expect(the_post).to_not be_valid
    end

    it 'accepts "The post title"' do
      the_post.title = 'The post title'
      expect(the_post).to be_valid
    end
  end

  context 'post.comments_counter' do
    it 'has some value' do
      the_post.comments_counter = nil
      expect(the_post).to_not be_valid
    end

    it 'is integer' do
      the_post.comments_counter = 1.2
      expect(the_post).to_not be_valid
    end

    it 'accpets 0 and 10' do
      [0, 10].each do |counter|
        the_post.comments_counter = counter
        expect(the_post).to be_valid
      end
    end
  end

  context 'post.likes_counter' do
    it 'has some value' do
      the_post.likes_counter = nil
      expect(the_post).to_not be_valid
    end

    it 'is integer' do
      the_post.likes_counter = 1.2
      expect(the_post).to_not be_valid
    end

    it 'accpets 0 and 10' do
      [0, 10].each do |counter|
        the_post.likes_counter = counter
        expect(the_post).to be_valid
      end
    end
  end

  context 'post.most_recent_five_comments' do
    it 'returns empty list if there is no comments' do
      expect(the_post.most_recent_five_comments).to eq []
    end

    it 'returns recent five comments in right order' do
      comment2.save!
      comment2.save!
      comment3.save!
      comment4.save!
      comment5.save!
      comment6.save!

      the_post.reload
      actual_comments = the_post.most_recent_five_comments.pluck(:text)
      expected_comments = [
        comment6.text,
        comment5.text,
        comment4.text,
        comment3.text,
        comment2.text
      ]
      expect(actual_comments).to eq expected_comments
    end
  end
end