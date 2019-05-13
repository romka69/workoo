require 'rails_helper'

feature 'The guest can see list a of all tasks' do
  given!(:tasks) { create_list(:task_sequence, 3) }

  scenario 'view list of tasks' do
    visit tasks_path

    tasks.each do |task|
      expect(page).to have_content task.title
      expect(page).to have_content task.body
      expect(page).to have_content task.price
    end
  end
end
