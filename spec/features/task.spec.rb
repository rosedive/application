# In this require, the feature required for Feature Spec such as Capybara are available.
require 'rails_helper'

# On the right side of this RSpec.feature, write the test item name like "task management feature" (grouped by do ~ end)
RSpec.feature "Task management function", type: :feature do
  # In scenario (alias of it), write the processing of the test for each item you want to check.
  background  do
    User.create!(name: "rose", email: 'rose@gmail.Com', user_type:'admin' , password: '123456')
    User.create!(name: "Nina", email: 'na@gmail.Com',  user_type:'admin' , password: '123456')
    visit new_session_path
    fill_in  'Email' ,  with: 'rose@gmail.Com'
    fill_in  'Password' ,  with: '123456'
    click_on 'LogIn'
    visit new_task_path
    fill_in  'Name' ,  with: 'name1'
    fill_in  'Status' ,  with: 'status1'
    fill_in  'Content' ,  with: 'content1'
    click_on  'Δημιουργήστε'
  end
  scenario "Test task list" do

    #Task.create!(name: 'test_task_01', status: 'test_task_01', content: 'testtesttest', prior: 'medium', start_date: '10.2.2019', end_date: '10.2.2019')
    #Task.create!(name: 'test_task_02', status: 'test_task_02', content: 'samplesample', prior: 'medium', start_date: '10.2.2019', end_date: '10.2.2019')
    visit tasks_path
    expect(page).to have_content 'name1'
    expect(page).to have_content 'content1'
  end

    scenario "Test task creation" do
    expect(page).to have_content 'name1'
    expect(page ).to  have_content  'content1'
end
  scenario "Test task details" do
    @task = Task.first
   visit task_path(id: @task.id)
   expect(page).to have_content('name1')
   expect(page).to have_content('content1')
  end
    scenario "Test whether tasks are arranged in descending order of creation date" do
    Ttask = Task.order('created_at DESC')
  end
  scenario "Test task updating" do
    @task = Task.first
   visit edit_task_path(id: @task.id)
   fill_in 'Name', with: 'name update'
   fill_in 'Content', with: 'content update'
   click_on 'Ενημερώστε'
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

end
