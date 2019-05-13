require 'rails_helper'

feature 'The guest can register as customer or executor' do

  describe 'Sign in' do
    background { visit new_user_session_path }

    scenario 'registered user tries to sign in' do
      User.create!(email: 'usertest@usertest.test', password: '12345678')

      fill_in 'Email', with: 'usertest@usertest.test'
      fill_in 'Password', with: '12345678'
      click_on 'Log in'

      expect(page).to have_content 'Вход в систему выполнен.'
    end

    scenario 'unregistered user tries to sign in' do
      fill_in 'Email', with: 'wrongusertest@usertest.test'
      fill_in 'Password', with: '12345678'
      click_on 'Log in'

      expect(page).to have_content 'Неверный Email или пароль.'
    end

  end

  describe 'Sign up' do
    scenario 'Unregistered user tries to sign up' do
      visit new_user_registration_path

      fill_in 'Email', with: 'usertest@usertest.test'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_on 'Sign up'

      expect(page).to have_content 'Добро пожаловать! Вы успешно зарегистрировались.'
    end
  end

  describe 'Log out' do
    scenario 'Logged user tries to log out'
  end
end
