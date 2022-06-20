require 'rails_helper'
RSpec.describe 'Users Show', type: :system do
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
    @comment1 = Comment.create(author_id: @user.id, post_id: @post1.id, text: 'This is a test comment')
    @comment2 = Comment.create(author_id: @user.id, post_id: @post1.id, text: 'This is another test comment')
    @like = Like.create(author_id: @user.id, post_id: @post1.id)
    visit 'users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'admin@email.com'
      fill_in 'Password', with: 'password'
    end
    find_button('Log in').click
    # click_link('My Profile')
    visit user_post_path(@user.id, @post1.id)
  end
  it 'I can see a post\'s title.' do
    expect(page).to have_content('Post 1')
  end
  it 'I can see who wrote the post.' do
    expect(page).to have_content("Post By: #{@user.name}")
  end
  it 'I can see how many comments a post has.' do
    expect(page).to have_content('Comments: 2')
  end
  it 'I can see how many likes a post has.' do
    expect(page).to have_content('Likes: 1')
  end
  it 'I can see the post body.' do
    expect(page).to have_content('This is first post')
  end
  it 'I can see the username of each commentor.' do
    expect(page).to have_content("#{@user.name}: #{@comment1.text}")
  end
  it 'I can see the comment each commentor left.' do
    expect(page).to have_content('admin: This is a test comment')
    expect(page).to have_content('admin: This is another test comment')
  end
end