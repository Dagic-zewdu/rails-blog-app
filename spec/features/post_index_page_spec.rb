require 'rails_helper'
require 'helpers/models_helper'

describe 'Post Index' do
  before do
    @name = 'user'
    @users = create_and_activate_user(@name)
    @posts = create_posts_for_user(@users, count: 4)
    @comments = create_comments_for_post_by_user(@posts.last, @users, count: 2)

    visit user_posts_path(@users)
  end

  it 'shows the user\'s profile picture' do
    expect(page).to have_css ''
  end

  it 'shows username' do
    expect(page).to have_content @users.name
  end

  it 'shows the number of posts the user has written' do
    expect(page).to have_content 'Number of posts: 4'
  end

  it 'shows a post\'s title' do
    expect(page).to have_content @posts.last.title
  end

  it 'shows some of the post\'s body' do
    expect(page).to have_content @posts.last.text
  end

  it 'shows the first comments on a post' do
    expect(page).to have_content @comments.first.text
  end

  it 'shows how many comments a post has' do
    expect(page).to have_content '2 Comments'
  end

  it 'shows how many likes a post has' do
    expect(page).to have_button '0 Likes'
  end

  it 'redirects to post page after clicking on it' do
    click_link @posts.last.title
    expect(page).to have_current_path(user_post_path(@users, @posts.last))
  end
end
