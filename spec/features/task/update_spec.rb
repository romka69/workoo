require 'rails_helper'

feature 'Update task' do
  given!(:customer) { create :user }
  given(:task) { create :task, author: customer }

  scenario 'Unauthenticated user can not edit task' do
    visit task_path(task)

    expect(page).to_not have_content 'Изменить задание'
  end

  describe 'Executor' do
    given(:executor) { create :user, :executor }

    scenario 'Executor tries update task' do
      sign_in(executor)
      visit task_path(task)

      expect(page).to_not have_content 'Изменить задание'
    end
  end

  describe 'Customer' do
    describe 'As author' do
      background do
        sign_in(customer)
        visit task_path(task)

        click_on 'Изменить задание'
      end

      scenario 'can update task' do
        fill_in 'Название задания', with: 'Измененный заголовок'
        fill_in 'Что нужно сделать?', with: 'Измененное тело'
        fill_in 'Цена', with: '14500541'
        click_on 'Опубликовать задание'

        expect(page).to have_content 'Измененный заголовок'
        expect(page).to have_content 'Измененное тело'
        expect(page).to have_content '14500541'

        expect(page).to have_content 'Задание обновлено'
      end

      scenario 'can not update not valid task' do
        fill_in 'Название задания', with: ''
        fill_in 'Что нужно сделать?', with: ''
        fill_in 'Цена', with: ''
        click_on 'Опубликовать задание'

        expect(page).to have_content 'Заголовок не может быть пустым'
      end
    end

    describe 'As not author' do
      given!(:customer2) { create :user }

      scenario 'can not update task' do
        sign_in(customer2)
        visit task_path(task)

        expect(page).to_not have_content 'Изменить задание'
      end
    end
  end
end
