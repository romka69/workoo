require 'rails_helper'

feature 'The guest can see list a of all comments' do
  given!(:user) { create :user }
  given!(:task) { create :task, author: user }
  given!(:comments) { create_list(:comment_sequence, 3, task: task) }

  scenario 'view list of comments' do
    visit task_path(task)

    comments.each do |comment|
      expect(page).to have_content comment.body

      expect(page).to have_content comment.author.email
    end
  end
end
