require 'rails_helper'

feature 'Delete bid' do
  given(:task) { create :task, :with_author }
  given(:executor) { create :user, :executor }
  given!(:bid) { create :bid, user: executor, task: task }

  scenario 'Unauthenticated user can not delete bid' do
    visit task_path(task)

    expect(page).to_not have_content 'Удалить заявку'
  end

  describe 'Customer' do
    given(:customer) { create :user }

    scenario 'can not delete bid' do
      sign_in(customer)
      visit task_path(task)

      expect(page).to_not have_content 'Удалить заявку'
    end
  end

  describe 'Executor', js: true do
    scenario 'can delete bid' do
      sign_in(executor)
      visit task_path(task)

      click_on 'Удалить заявку'

      expect(page).to_not have_content 'Удалить заявку'
      expect(page).to have_content 'Подать заявку'
    end
  end
end
