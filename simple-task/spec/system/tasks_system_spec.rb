require "rails_helper"

RSpec.describe "tasks management", type: :system do

  before do
    @user = create(:user)
    sign_in(@user)
  end

  after do
    sign_out(@user)
  end

  def create_a_task
    task = build(:task)
    @task = @user.tasks.build({title: task.title, body: task.body, client: task.client, duration: task.duration, status: task.status, user_id: @user.id})
    @task.save
  end

  it "user can add a new task" do
    visit root_path

    click_on "New Task"

    @task = build(:task)
    fill_in "task_title", with: @task.title
    fill_in "task_body", with: @task.body
    select @task.client
    fill_in "task_duration", with: @task.duration
    check "task_status"

    click_on "Create Task"

    within('h1') do
      expect(page).to have_content('Tasks List')
    end

    expect(Task.all.first.title).to eq(@task.title)
    expect(Task.all.first.client).to eq(@task.client)
    expect(Task.all.first.status).to eq(@task.status)
  end

  it "user can edit an existing task" do
    create_a_task

    visit root_path

    click_on "Edit"


    fill_in "task_title", with: @task.title + '!'
    select "Molson"
    uncheck "task_status"
    click_on "Update Task"


    expect(Task.count).to eq(1)
    expect(Task.all.first.title).to eq(@task.title + '!')
    expect(Task.all.first.client).to eq("Molson")
    expect(Task.all.first.status).to eq("pending")
  end

  it "user can delete an existing task" do
    create_a_task

    visit root_path

    within('h1') do
      expect(page).to have_content('Tasks List')
    end

    accept_confirm do
      click_on "Delete"
    end

    within('h1') do
      expect(page).to have_content('Tasks List')
    end

    expect(Task.count).to eq(0)
  end

end
