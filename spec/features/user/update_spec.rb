require 'rails_helper'

feature 'Update user profile' do
  given!(:user) { create :user }

  scenario 'Unauthenticated user can not edit profile' do
    visit user_path(user)

    expect(page).to_not have_content 'Редактировать профиль'
  end

  describe 'User' do
    describe 'Her profile', js: true do
      scenario 'can update profile' do
        sign_in(user)
        visit user_path(user)
        click_on 'Редактировать профиль'

        fill_in 'Имя', with: 'Сан'
        fill_in 'Фамилия', with: 'Саныч'
        fill_in 'Город', with: 'Сидней'
        # birth date picked automatically
        fill_in 'Обо мне', with: 'Hello rails'

        click_on 'Обновить'

        expect(page).to have_content user.first_name
        expect(page).to have_content user.last_name
        expect(page).to have_content user.city
        expect(page).to have_content user.birth_date
        expect(page).to have_content user.about
      end
    end

    describe 'Not her profile' do
      given!(:user2) { create :user }

      scenario 'can not update profile' do
        sign_in(user2)
        visit user_path(user)

        expect(page).to_not have_content 'Редактировать профиль'
      end
    end
  end
end
