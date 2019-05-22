require 'rails_helper'

feature 'The guest can register as customer or executor' do

  describe 'Sign in' do
    background do
      visit root_path
      click_on 'Логин'
    end

    scenario 'unregistered user tries to sign in' do
      fill_in 'Email', with: 'wrongusertest@usertest.test'
      fill_in 'Password', with: '12345678'
      click_on 'Log in'

      expect(page).to have_content 'Неверный Email или пароль.'
    end

    describe 'Registered' do
      scenario 'registered customer tries to sign in' do
        User.create!(email: 'usertest@usertest.test', password: '12345678', role: Role.create!(role_name: 'customer'))

        fill_in 'Email', with: 'usertest@usertest.test'
        fill_in 'Password', with: '12345678'
        click_on 'Log in'

        expect(page).to have_content 'Вход в систему выполнен.'
      end

      scenario 'registered executor tries to sign in' do
        User.create!(email: 'usertest@usertest.test', password: '12345678', role: Role.create!(role_name: 'executor'))

        fill_in 'Email', with: 'usertest@usertest.test'
        fill_in 'Password', with: '12345678'
        click_on 'Log in'

        expect(page).to have_content 'Вход в систему выполнен.'
      end
    end
  end

  describe 'Sign up' do
    background do
      Role.create!(role_name: 'customer')
      Role.create!(role_name: 'executor')

      visit root_path
      click_on 'Регистрация'

      sleep 0.4

      fill_in 'Email', with: 'usertest@usertest.test'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
    end

    scenario 'Unregistered customer tries to sign up' do
      click_on 'Sign up'

      expect(page).to have_content 'Добро пожаловать! Вы успешно зарегистрировались.'
    end

    scenario 'Unregistered executor tries to sign up' do
      #find("input[name='user[role]']").click
      #find('#user_role').click
      find(:css, 'label', text: 'Зарегистрироваться как исполнитель').click
      save_and_open_page
      click_on 'Sign up'

      expect(page).to have_content 'Добро пожаловать! Вы успешно зарегистрировались.'
    end
  end
end
