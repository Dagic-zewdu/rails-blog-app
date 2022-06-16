require 'rails_helper'

RSpec.describe 'Posts index page', type: :system do
  before do
    driven_by(:rack_test)
    @user = User.create(name: 'admin',
                        email: 'admin@email.com',
                        password: 'password', password_confirmation: 'password',
                        photo: 'photo-url',
                        bio: 'I am spiderman')
    @user.save
    @post1 = Post.create(author_id: @user.id, title: 'Post 1', text: 'This is first post')
    @post2 = Post.create(author_id: @user.id, title: 'Post 2', text: 'This is second post')
    @post3 = Post.create(author_id: @user.id, title: 'Post 3', text: 'This is third post')

    @comment = Comment.create(author_id: @user.id, post_id: @post1.id, text: 'This is a test comment')

    @like = Like.create(author_id: @user.id, post_id: @post1.id)
    visit 'users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'admin@email.com'
      fill_in 'Password', with: 'password'
    end
    find_button('Log in').click
    click_link('My Profile')
  end

  it 'I can see the user\'s profile picture.' do
    expect(page).to have_css("img[src*='photo-url']")
  end

  it 'I can see the user\'s username.' do
    expect(page).to have_content('admin')
  end

  it 'I can see the number of posts the user has written.' do
    expect(page).to have_content('Number of posts: 3')
  end

  it 'I can see a post\'s title.' do
    expect(page).to have_content('Post 1')
  end

  it 'I can see some of the post\'s body.' do
    expect(page).to have_content('This is first post')
  end

  it 'I can see the first comment on a post.' do
    click_link('Show all posts')
    expect(page).to have_content('This is a test comment')
  end

  it 'I can see how many comments a post has.' do
    expect(page).to have_content('Comments: 1')
  end

  it 'I can see how many likes a post has.' do
    expect(page).to have_content('Likes: 1')
  end

  it 'When I click on a post, it redirects me to that post\'s show page.' do
    click_link('View post 1')
    expect(current_path).to eql(user_post_path(@user.id, @post1.id))
  end
end