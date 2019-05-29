require 'rails_helper'

feature 'Approve executor' do
  given(:customer) { create :user }
  given(:task) { create :task, author: customer }
  given(:executor) { create :user, :executor }
  given!(:bid) { create :bid, user: executor, task: task }

  scenario 'Unauthenticated user can not approved' do
    visit task_path(task)

    expect(page).to_not have_content 'Утвердить'
  end

  describe 'Customer' do
    given(:customer2) { create :user }

    scenario 'As author can approved', js: true do
      sign_in(customer)
      visit task_path(task)

      click_on 'Утвердить'

      expect(page).to have_content 'Исполнитель выбран'
    end

    scenario 'As not author can not approved' do
      sign_in(customer2)
      visit task_path(task)

      expect(page).to_not have_content 'Утвердить'
    end
  end

  describe 'Executor' do
    scenario 'can can not approved' do
      sign_in(executor)
      visit task_path(task)

      expect(page).to_not have_content 'Утвердить'
    end
  end
end
