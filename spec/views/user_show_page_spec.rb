require 'rails_helper'

RSpec.describe 'Users Show Page', type: :system do
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

  it 'I can see the user\'s bio.' do
    expect(page).to have_content('I am spiderman')
  end

  it 'I can see the user\'s first 3 posts.' do
    expect(page).to have_content('This is first post')
    expect(page).to have_content('This is second post')
    expect(page).to have_content('This is third post')
  end

  it 'I can see a button that lets me view all of a user\'s posts.' do
    expect(page).to have_content('Show all posts')
  end

  it 'When I click a user\'s post, it redirects me to that post\'s show page.' do
    click_link('View post 1')
    expect(current_path).to eql(user_post_path(@user.id, @post1.id))
  end

  it 'When I click to see all posts, it redirects me to the user\'s post\'s index page.' do
    click_link('Show all posts')
    expect(current_path).to eql(user_posts_path(@user.id))
  end
end