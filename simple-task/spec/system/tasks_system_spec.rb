require "rails_helper"

RSpec.describe "tasks management", type: :system do
  let(:user) { create(:user) }
  
  before do
    sign_in(user)
  end  

  after do
    sign_out(user)
  end 

  context "create task" do
    it "create a new task" do
      visit root_path
      click_on "New Task"

      task = build(:task)
      fill_in "task_title", with: task.title
      fill_in "task_body", with: task.body
      select task.client
      fill_in "task_duration", with: task.duration
      check "task_status"

      click_on "Create Task"

      expect(page).to have_content(task.title)
    end 
  end

  context "edit task" do
    let!(:task) { create(:task, user: user) }

    it "edit an existing task" do
      visit root_path
      click_on "Edit"

      fill_in "task_title", with: task.title + '!'
      click_on "Update Task"
      
      expect(page).to have_content(task.title + '!')     
    end  
  end

  context "delete task" do
    let!(:task) { create(:task, user: user) }

    it "delete an existing task" do
      visit root_path

      accept_confirm do
        click_on "Delete"
      end

      expect(page).to have_content('There is no tasks.')
    end  
  end
  
end
