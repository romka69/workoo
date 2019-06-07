require 'rails_helper'

feature 'Complete task' do
  given!(:customer) { create :user }
  given(:task) { create :task, author: customer }
  given!(:executor) { create :user, :executor }

  scenario 'Unauthenticated user can not complete task' do
    visit task_path(task)

    expect(page).to_not have_content 'Закрыть задание'
  end

  describe 'Executor' do
    scenario 'Executor can not complete task' do
      sign_in(executor)
      visit task_path(task)

      expect(page).to_not have_content 'Закрыть задание'
    end
  end

  describe 'Customer' do
    describe 'As author' do
      background do
        sign_in(customer)
      end

      scenario 'can not complete task without approve' do
        visit task_path(task)

        expect(page).to_not have_content 'Закрыть задание'
      end

      given!(:bid) { create :bid, user: executor, task: task }


      scenario 'can update task', js: true do
        bid.update!(approve: true)
        visit task_path(task)
        click_on 'Закрыть задание'

        expect(page).to have_content 'Задание выполненно и закрыто'
      end
    end

    describe 'As not author' do
      given!(:customer2) { create :user }

      scenario 'can not complete task' do
        sign_in(customer2)
        visit task_path(task)

        expect(page).to_not have_content 'Закрыть задание'
      end
    end
  end
end
