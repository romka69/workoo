require 'rails_helper'

feature 'The guest can register as customer or executor' do
  describe 'Sign in' do
    background do
      visit root_path
      click_on 'Логин'
    end

    scenario 'unregistered user tries to sign in' do
      fill_in 'Электронная почта', with: 'wrongusertest@usertest.test'
      fill_in 'Пароль', with: '12345678'
      click_on 'Войти'

      expect(page).to have_content 'Неверный Email или пароль.'
    end

    describe 'Registered' do
      scenario 'customer tries to sign in' do
        User.create!(email: 'usertest@usertest.test', password: '12345678', role: Role.create!(role_name: 'customer'))

        fill_in 'Электронная почта', with: 'usertest@usertest.test'
        fill_in 'Пароль', with: '12345678'
        click_on 'Войти'

        expect(page).to have_content 'Вход в систему выполнен.'
      end

      scenario 'executor tries to sign in' do
        User.create!(email: 'usertest@usertest.test', password: '12345678', role: Role.create!(role_name: 'executor'))

        fill_in 'Электронная почта', with: 'usertest@usertest.test'
        fill_in 'Пароль', with: '12345678'
        click_on 'Войти'

        expect(page).to have_content 'Вход в систему выполнен.'
      end
    end
  end

  describe 'Sign up' do
    background do
      Role.create!([{ role_name: 'customer' }, { role_name: 'executor' }])

      visit root_path
      click_on 'Регистрация'

      sleep 0.2

      fill_in 'Электронная почта', with: 'usertest@usertest.test'
      fill_in 'Пароль', with: '12345678'
      fill_in 'Пароль еще раз', with: '12345678'
    end

    scenario 'unregistered customer tries to sign up' do
      click_on 'Зарегистрироваться'

      expect(page).to have_content 'Добро пожаловать! Вы успешно зарегистрировались.'
    end

    scenario 'unregistered executor tries to sign up' do
      find(:css, 'label', text: 'Зарегистрироваться как исполнитель').click
      click_on 'Зарегистрироваться'

      expect(page).to have_content 'Добро пожаловать! Вы успешно зарегистрировались.'
    end
  end

  describe 'Log out' do
    background do
      User.create!(email: 'usertest@usertest.test', password: '12345678', role: Role.create!(role_name: 'customer'))
      User.create!(email: 'usertest2@usertest.test', password: '12345678', role: Role.create!(role_name: 'executor'))

      visit new_user_session_path
    end

    scenario 'customer tries to log out' do
      fill_in 'Электронная почта', with: 'usertest@usertest.test'
      fill_in 'Пароль', with: '12345678'
      click_on 'Войти'

      sleep 0.2

      click_on 'Выйти'

      expect(page).to have_content 'Выход из системы выполнен.'
    end

    scenario 'executor tries to log out' do
      fill_in 'Электронная почта', with: 'usertest2@usertest.test'
      fill_in 'Пароль', with: '12345678'
      click_on 'Войти'

      sleep 0.2

      click_on 'Выйти'

      expect(page).to have_content 'Выход из системы выполнен.'
    end
  end
end
