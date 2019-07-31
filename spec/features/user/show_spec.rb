require 'rails_helper'

feature 'Show profile' do
  include UsersHelper

  given!(:user) { create :user, :profile }

  scenario 'Unauthenticated user not can link to his profile' do
    visit root_path

    expect(page).to_not have_content 'Профиль'
  end

  scenario 'Unauthenticated user can show another user profile' do
    visit user_path(user)

    expect(page).to have_content full_name
    expect(page).to have_content user.email
    expect(page).to have_content user.city
    expect(page).to have_content age
    expect(page).to have_content user.about
  end

  scenario 'Authenticated user can show user profile' do
    sign_in(user)
    visit root_path
    click_on 'Профиль'

    expect(page).to have_content full_name
    expect(page).to have_content user.email
    expect(page).to have_content user.city
    expect(page).to have_content age
    expect(page).to have_content user.about
  end
end
