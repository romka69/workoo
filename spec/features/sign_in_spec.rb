require 'rails_helper'

feature 'The guest can Sign in/Sign up in service' do
  describe 'Sign in via email' do
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

  describe 'Sign up via email' do
    scenario 'unregistered user tries to sign up with errors' do
      visit root_path
      click_on 'Регистрация'
      click_on 'Зарегистрироваться'

      expect(page).to have_content 'сохранение не удалось'
    end

    background do
      Role.create!([{ role_name: 'customer' }, { role_name: 'executor' }])

      visit root_path
      click_on 'Регистрация'

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

  describe 'Sign in/up with oAuth' do
    scenario 'Yandex' do
      Role.create!(role_name: 'not selected')
      visit new_user_registration_path
      expect(page).to have_content("Войти через Yandex")
      mock_auth_hash
      click_on 'Войти через Yandex'

      expect(page).to have_content 'Вход в систему выполнен с учётной записью из Yandex'
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
