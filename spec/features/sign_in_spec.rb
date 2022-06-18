require 'rails_helper'

RSpec.describe 'LoginPage', type: :system do
  before do
    driven_by(:rack_test)
    visit 'users/sign_in'
  end

  it 'I can see the email and password inputs and the "Submit" button.' do
    expect(page).to have_selector('input[type="email"]')
    expect(page).to have_selector('input[type="password"]')
    expect(page).to have_selector('input[type="submit"]')
  end

  it 'When I click the submit button without filling in the username and the password, I get a detailed error' do
    find_button('Log in').click
    expect(page).to have_content('Invalid Email or password.')
  end

  it 'When I click the submit button after filling in the username and the
   password with incorrect data, I get a detailed error.' do
    within('#new_user') do
      fill_in 'Email', with: 'email@email.com'
      fill_in 'Password', with: 'password'
    end
    find_button('Log in').click
    expect(page).to have_content('Invalid Email or password.')
  end
  it 'When I click the submit button after filling in the username and
  the password with correct data, I am redirected to the root page.' do
    user = User.create(name: 'admin',
                       email: 'admin@email.com',
                       password: 'password', password_confirmation: 'password',
                       photo: 'photo url',
                       bio: 'I am spiderman')
    user.save
    within('#new_user') do
      fill_in 'Email', with: 'admin@email.com'
      fill_in 'Password', with: 'password'
    end
    find_button('Log in').click
    expect(page).to have_content("Signed in successfully.")
  end
end