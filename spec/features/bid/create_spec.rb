require 'rails_helper'

feature 'Create bid' do
  given(:task) { create :task, :with_author }

  scenario 'Unauthenticated user can not create bid' do
    visit task_path(task)

    expect(page).to_not have_content 'Подать заявку'
  end

  describe 'Customer' do
    given(:customer) { create :user }

    scenario 'can not create bid' do
      sign_in(customer)
      visit task_path(task)

      expect(page).to_not have_content 'Подать заявку'
    end
  end

  describe 'Executor', js: true do
    given(:executor) { create :user, :executor }

    scenario 'can create bid' do
      sign_in(executor)
      visit task_path(task)

      click_on 'Подать заявку'

      expect(page).to_not have_content 'Подать заявку'
      expect(page).to have_content 'Удалить заявку'
    end
  end
end
