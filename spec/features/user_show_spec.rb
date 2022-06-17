require 'rails_helper'
require 'helpers/models_helper'

describe 'User Show', type: :feature do
  before do
    @name = 'user'
    @user = create_and_activate_user(@name)
    create_posts_for_user(@user, count: 4)

    visit user_path(@user)
  end

  it 'shows the profile picture of user' do
    expect(page).to have_css "img[src='#{@name}.jpg']"
  end

  it 'shows username of user' do
    expect(page).to have_content @name
  end

  it 'shows the count of posts by user i.e. 4' do
    expect(page).to have_content 'Number of posts: 4'
  end

  it 'shows the bio of user' do
    expect(page).to have_content "Bio of #{@name}"
  end

  it 'shows the last 3 posts by user' do
    3.downto(1).each { |i| expect(page).to have_content "This is body of post #{i}" }
  end

  it 'shows a button to show all posts by user' do
    expect(page).to have_link 'See all posts'
  end

  it 'gets redirected to post page after user clicks on a post' do
    click_link 'Post 1'

    expect(page).to have_current_path(user_post_path(@user, @user.posts.second))
  end

  it 'gets redirected to all posts page when user clicks on see all posts button' do
    click_link 'See all posts'

    expect(page).to have_current_path(user_posts_path(@user))
  end
end
