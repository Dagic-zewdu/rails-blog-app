require 'rails_helper'

RSpec.describe 'Users', type: :system do
  context 'index page' do
    before(:each) do
      driven_by(:rack_test)
      @user = User.create(name: 'admin',
                          email: 'admin@email.com',
                          password: 'password', password_confirmation: 'password',
                          photo: 'photo-url',
                          bio: 'I am spiderman')
      @user.save
      visit 'users/sign_in'
      within('#new_user') do
        fill_in 'Email', with: 'admin@email.com'
        fill_in 'Password', with: 'password'
      end
      find_button('Log in').click
    end

    it 'should show username of user/users' do
      expect(page).to have_content('admin')
    end

    it 'should show image of user/users' do
      expect(page).to have_css("img[src*='photo-url']")
    end

    it 'should show number of posts of user/users' do
      expect(page).to have_content('Number of posts: 0')
    end

  end
end