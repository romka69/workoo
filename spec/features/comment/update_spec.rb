require 'rails_helper'

feature 'Update comment' do
  given!(:user) { create :user }
  given!(:task) { create :task, author: user }
  given!(:comment) { create :comment, task: task, author: user }

  scenario 'Unauthenticated user can not edit comment' do
    visit task_path(task)

    expect(page).to_not have_content 'Изменить комментарий'
  end

  describe 'User' do
    describe 'As author', js: true do
      scenario 'can not update not valid comment' do
        sign_in(user)
        visit task_path(task)
        click_on 'Изменить комментарий'

        fill_in 'comment_body_edit', with: ''
        click_on 'Сохранить'

        expect(page).to have_content 'Комментарий не может быть пустым'
      end

      describe 'If edit time' do
        include ActiveSupport::Testing::TimeHelpers

        scenario 'not left, can update' do
          sign_in(user)
          visit task_path(task)
          click_on 'Изменить комментарий'

          fill_in 'comment_body_edit', with: 'Измененный комментарий'
          click_on 'Сохранить'

          expect(page).to have_content 'Измененный комментарий'
        end

        scenario 'left, can not update' do
          travel_to(Time.now.utc + 6.minutes) do
            sign_in(user)
            visit task_path(task)

            expect(page).to_not have_content 'Изменить комментарий'
          end
        end
      end
    end

    describe 'As not author' do
      given!(:user2) { create :user }

      scenario 'can not update comment' do
        sign_in(user2)
        visit task_path(task)

        expect(page).to_not have_content 'Изменить комментарий'
      end
    end
  end
end
