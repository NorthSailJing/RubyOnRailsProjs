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
    let(:task) { build(:task, user: user) }

    before do 
      visit root_path
      click_on "New Task"
      fill_in "task_title", with: task.title
      fill_in "task_body", with: task.body
      select task.client
      fill_in "task_duration", with: task.duration
      check "task_status"
      click_on "Create Task"
    end  

    it "create a new task" do
      expect(page).to have_content(task.title)
    end 
  end

  context "edit task" do
    let!(:task) { create(:task, user: user) }

    before do 
      visit root_path
      click_on "Edit"   
      fill_in "task_title", with: task.title + '!'
      click_on "Update Task"
    end  

    it "edit an existing task" do       
      expect(page).to have_content(task.title + '!')     
    end  
  end

  context "delete task" do
    let!(:task) { create(:task, user: user) }

    before do 
      visit root_path

      accept_confirm do
        click_on "Delete"
      end
    end

    it "delete an existing task" do
      expect(page).to have_content('There is no tasks.')
    end  
  end
  
end
