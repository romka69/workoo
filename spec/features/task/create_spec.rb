require 'rails_helper'

feature 'Create task' do
  describe 'Authenticated' do
    given(:customer) { create :user }
    given(:executor) { create :user, :executor }

    describe 'Customer' do
      background do
        sign_in(customer)
        visit tasks_path
        click_on 'Создать задание'
      end

      scenario 'create valid task' do
        fill_in 'Название задания', with: 'Тест заголовка'
        fill_in 'Что нужно сделать?', with: 'Тестовое наполнение'
        fill_in 'Цена', with: '777'
        click_on 'Опубликовать задание'

        expect(page).to have_content 'Задание создано'
        expect(page).to have_content 'Тест заголовка'
        expect(page).to have_content 'Тестовое наполнение'
      end

      scenario 'create not valid task' do
        click_on 'Опубликовать задание'

        expect(page).to have_content 'Заголовок не может быть пустым'
      end
    end

    scenario 'executor tries create task' do
      sign_in(executor)
      visit tasks_path

      expect(page).to_not have_content 'Создать задание'
    end
  end

  scenario 'Unauthenticated user tries create task' do
    visit tasks_path

    expect(page).to_not have_content 'Создать задание'
  end
end
