require "rails_helper"
require "selenium/webdriver"

RSpec.describe "tasks management", type: :system do
  let(:user) { create(:user) }
  let!(:client) { create(:client) }

  before do
    sign_in(user)
  end  

  after do
    sign_out(user)
  end 

  context "when filling in creating a task form" do
    let(:task) { build(:task, user: user, client: client) }

    before do 
      visit root_path
      click_on "New Task", match: :first
      fill_in "task_title", with: task.title
      fill_in "task_body", with: task.body
      select task.client.name
      fill_in "task_duration", with: task.duration
      check "task_status"
      click_on "Create Task"
    end  

    it "when successful" do
      expect(page).to have_content(task.title)
    end 
  end

  context "when filling in updating a task form" do
    let!(:task) { create(:task, user: user, client: client) }

    before do 
      visit root_path
      click_on "Edit", match: :first   
      fill_in "task_title", with: task.title + '!'
      click_on "Update Task"
    end  

    it "when successful" do       
      expect(page).to have_content(task.title + '!')     
    end  
  end

  context "when clicking the delete task link" do
    before do 
      create(:task, user: user, client: client)
      visit root_path

      accept_confirm do
        click_on "Delete", match: :first
      end
    end

    it "when successful" do
      expect(page).to have_content('There is no tasks.')
    end  
  end

  context "when visiting the tasks list page" do   
    before do
      create_list(:task, 3, user: user, client: client, status: 1)
      create_list(:task, 2, user: user, client: client, status: 0)
      
      visit root_path
    end  

    it "shows the completed hours" do
      expect(page).to have_content("Total completed hours: 60")
    end
  end

  context "when clicking the download link" do
    let(:path_to_file) {"c:/users/jinglun/downloads/tasks-#{Date.today}.csv"}
    let!(:task) { create(:task, user: user, client: client) }

    before do
      File.delete(path_to_file) if File.exist?(path_to_file)

      visit root_path
      click_on "Download Tasks List"
      sleep 1
    end 

    it "downloads the task to csv" do
      expect { path_to_file }.to_not raise_error
    end  
    
    it "generates the correct header" do
      header = CSV.open(path_to_file, 'r') { |csv| csv.first.to_s }
      expect(header).to eq("[\"title|body|client_name|duration|status\"]")
    end

    it "generates the correct content" do
      content = CSV.open(path_to_file, 'r').drop(1) { |csv| csv.first.to_s }
      expect(content).to eq([[task.title + "|" + task.body + "|" + task.client_name + "|" + task.duration.to_s + "|" + task.status]])
    end   

  end 

end
