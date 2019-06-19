require 'rails_helper'

feature 'Create review' do
  given(:customer) { create :user }
  given!(:task) { create :task, author: customer }
  given!(:executor) { create :user, :executor }
  given!(:bid) { create :bid, user: executor, task: task, approve: true }

  background do
    task.set_executor(bid.user)
    task.set_complete
  end

  scenario 'Unauthenticated user can not create review' do
    visit task_path(task)

    expect(page).to_not have_content 'Оставьте отзыв о'
  end

  describe 'Authenticated user', js: true do
    describe 'Customer' do
      background do
        sign_in(customer)
        visit task_path(task)
      end

      scenario 'create valid review only 1 time' do
        fill_in 'review_body', with: 'Тест отзыва'
        click_on 'Отправить'

        expect(page).to have_content 'Отзыв оставлен'

        page.evaluate_script 'window.location.reload()'

        expect(page).to have_content 'Отзыв оставлен'
        expect(page).to_not have_content 'Оставьте отзыв о'
      end

      scenario 'can not create not valid review' do
        click_on 'Отправить'

        expect(page).to have_content 'Отзыв не может быть пустым'
      end
    end

    describe 'Executor' do
      background do
        sign_in(executor)
        visit task_path(task)
      end

      scenario 'create valid review only 1 time' do
        fill_in 'review_body', with: 'Тест отзыва 2'
        click_on 'Отправить'

        expect(page).to have_content 'Отзыв оставлен'

        page.evaluate_script 'window.location.reload()'

        expect(page).to have_content 'Отзыв оставлен'
        expect(page).to_not have_content 'Оставьте отзыв о'
      end
    end
  end
end
