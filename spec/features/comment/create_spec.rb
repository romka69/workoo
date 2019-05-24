require 'rails_helper'

feature 'Create comment' do
  given(:user) { create :user }
  given(:task) { create :task, author: user }

  scenario 'Unauthenticated user can not create comment' do
    visit task_path(task)

    expect(page).to_not have_content 'Оставьте комментарий'
    expect(page).to_not have_content 'Опубликовать'
  end

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit task_path(task)
    end

    scenario 'create valid task' do
      fill_in 'comment_body', with: 'Тест комментария'
      click_on 'Опубликовать'

      expect(page).to have_content 'Тест комментария'

      within '.comment-list.comment' do
        expect(page).to have_content user.email
      end
    end

    scenario 'can not create not valid comment' do
      click_on 'Опубликовать'

      expect(page).to have_content 'Комментарий не может быть пустым'
    end
  end
end
