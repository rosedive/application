# In this require, the feature required for Feature Spec such as Capybara are available.
require 'rails_helper'
# On the right side of this RSpec.feature, write the test item name like "task management feature" (grouped by do ~ end)
RSpec.feature "user management function", type: :feature do
 # In scenario (alias of it), write the processing of the test for each item you want to check.
 background do
   User.create!(name: "narda", email: 'narda@gmail.Com', user_type: 'admin',  password: '123456')
   visit  login_path
   #click_on 'Login'
   fill_in  'Email' ,  with: 'narda@gmail.Com'
   fill_in  'Password' ,  with: '123456'
   click_on  'Login'
 end
 scenario "Test number of users" do
   User.create!(name: 'rose', email: 'rose@gmail.com', user_type: 'admin', password: '123456')
   @user = User.all.count
   expect(@user).to eq 2
 end
 scenario "Test user list" do
   User.create!(name: 'rose', email: 'rose@gmail.com', user_type: 'admin', password: '123456')
   visit admin_users_path
   expect(page ).to  have_content  'narda'
   expect(page ).to  have_content  'rose'
 end
 scenario "Test user creation" do
   User.create!(name: 'rose', email: 'rose@gmail.com', user_type: 'admin', password: '123456')
   visit admin_users_path
   expect(page ).to  have_content  'narda'
 end
 scenario "test enable user creation page" do
   visit admin_users_path
   expect(page ).to  have_content  'narda'
 end
 scenario "Test user details" do
   @user= User.create!(name: 'narda', email: 'narda@gmail.com', user_type: 'admin', password: '123456')
   visit admin_user_path(id: @user.id)
   expect(page).to have_content('narda@gmail.com')
   expect(page).to have_content('admin')
 end
 scenario "Test user updating" do
   @user = User.first
   visit edit_user_path(id: @user.id)
   fill_in 'Name', with: 'name update'
   #fill_in 'Content', with: 'content update'
   click_on 'Ενημερώστε User'
   visit admin_users_path
   expect(page).to have_content('name update')
   #expect(page).to have_content('content update')
 end
 scenario 'Test Task Deletion' do
   User.create!(name: 'rose', email: 'rose@gmail.com', user_type: 'admin', password: '123456')
   @user = User.last
   @user.destroy
   # expect(page).to have_content('testtesttest')
   # click_on 'Destroy'
   visit users_path
   expect(page).not_to have_content('rose')
 end
end


