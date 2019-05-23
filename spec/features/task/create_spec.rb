require 'rails_helper'

feature 'Create task' do
  scenario 'Unauthenticated user can not create task' do
    visit tasks_path

    expect(page).to_not have_content 'Создать задание'
  end

  describe 'Executor' do
    given(:executor) { create :user, :executor }

    scenario 'can not create task' do
      sign_in(executor)
      visit tasks_path

      expect(page).to_not have_content 'Создать задание'
    end
  end

  describe 'Customer' do
    given(:customer) { create :user }

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

      within 'ul.blog-info-link' do
        expect(page).to have_content customer.email
      end
    end

    scenario 'can not create not valid task' do
      click_on 'Опубликовать задание'

      expect(page).to have_content 'Заголовок не может быть пустым'
    end
  end
end
