# In this require, the feature required for Feature Spec such as Capybara are available.
require 'rails_helper'

# On the right side of this RSpec.feature, write the test item name like "task management feature" (grouped by do ~ end)
RSpec.feature "Task management function", type: :feature do
  # In scenario (alias of it), write the processing of the test for each item you want to check.
  background do
    User.create!(name: "kavuna", email: 'kavuna@gmail.Com', user_type: 'admin',  password: '123456')
    visit  login_path
    #click_on 'Login'
    fill_in  'Email' ,  with: 'kavuna@gmail.Com'
    fill_in  'Password' ,  with: '123456'
    click_on  'Login'
    visit  tasks_path
    click_on 'New Task'
      fill_in  'Name' ,  with: 'task1'
      fill_in  'Content' ,  with: 'content1'
      fill_in  'Status' ,  with: 'priority1'
      #fill_in  'Priority' ,  with: 'priority1'
      # fill_in  'Status' ,  with: 'status1'
      # fill_in  'Priority' ,  with: 'Priority1'
      click_on 'Δημιουργήστε'
  end
  scenario "Test task list" do
    # visit  signup_path
    # fill_in  'Name' ,  with: 'new'
    # fill_in  'Email' ,  with: 'Foo@gmail.Com'
    # fill_in  'Password' ,  with: '123456'
    # #fill_in  'ConfirmationPassword' ,  with: '123456'
    # click_on  'Create'
    visit root_path
    save_and_open_page
    expect(page).to have_content 'task1'
    expect(page).to have_content 'content1'
  end
  scenario "Test task creation" do
    # visit to new_task_path (transition to task registration page)
    visit new_task_path
    fill_in  'Name' ,  with: 'completed'
    fill_in  'Content' ,  with: 'ruby task'
    fill_in  'Status' ,  with: 'status1'
    click_on  'Δημιουργήστε'
    expect(page ).to  have_content  'ruby task'
  end
  scenario "Test task details" do
    @task = Task.first
    visit task_path(id: @task.id)
    expect(page).to have_content('task1')
    expect(page).to have_content('content1')
  end
  scenario "Test whether tasks are arranged in descending order of creation date" do
    task = Task.order('created_at DESC')
  end
  scenario "Test task updating" do
    @task = Task.first
    visit edit_task_path(id: @task.id)
    fill_in 'Name', with: 'name update'
    fill_in 'Content', with: 'content update'
    click_on 'Ενημερώστε Task'
    visit tasks_path
    expect(page).to have_content('name update')
    expect(page).to have_content('content update')
  end
  scenario 'Test Task Deletion' do
    @task = Task.first
    @task.destroy
    # expect(page).to have_content('testtesttest')
    # click_on 'Destroy'
    visit tasks_path
    expect(page).not_to have_content('content1')
  end
  scenario "Test whether tasks are arranged in descending order of deadline" do
    click_on 'New Task'
      fill_in  'Name' ,  with: 'task2'
      fill_in 'Status' , with: 'status2'
      fill_in  'Content' ,  with: 'content2'
      # fill_in  'Status' ,  with: 'status2'
      # fill_in  'Priority' ,  with: 'Priority2'
      #fill_in  'End date' ,  with: '10.2.2019'
      click_on 'Δημιουργήστε'
      @task = Task.first
      @task_newest = Task.last
      @task_newest.end_date = '10.10.2020'
      @task_newest.save
      #Task.order('created_at desc').all.expect == [@task_newest, @email]
      task  = Task.order('end_date desc').all
    expect(task).to eq([@task_newest, @task])
  end
  scenario "test task search by attached labels " do
    #click_on 'Creaate Own Labels'
    #click_on 'New Label'
    visit new_label_path
    fill_in 'Title', with: 'label title1'
    fill_in 'Content', with: 'label content1'
    click_on 'Δημιουργήστε Label'
    # click_on 'Creaate Own Labels'
    # click_on 'New Label'
    visit new_label_path
    fill_in 'Title', with: 'label title2'
    fill_in 'Content', with: 'label content2'
    click_on 'Δημιουργήστε Label'
    @task = Task.first
    @label1 = Label.first
    @label2 = Label.last
    @task.labels = [@label1,@label2]
    @task.save
    visit tasks_path
    fill_in  'term3' ,  with: 'label title1'
    click_on '  Search'
    expect(page).to have_content('content1')
  end



end
