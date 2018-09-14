require 'rails_helper'
require 'spec_helper'

feature 'the signup process' do 
  background :each do 
    visit new_user_path
  end
  
  scenario 'has a sign up page ' do
    expect(page).to have_content('Sign Up')
    # expect(page).to have_content('password')
    # expect(page).to have_content('email')
  end
  
  feature 'signing up a user' do 
    scenario 'shows user name on the home page after sign up' do
      expect(page).to have_content("#{self.username}")
    end
    
  end 
end 
  
feature 'logging in' do
  background :each do
    visit new_user_path
    user = User.create(username: 'Joseph',password: 'starwars')
    fill_in 'username', with: 'Joseph'
    fill_in 'password', with: 'starwars'
    click_button 'Login'
    
  end
  
  scenario 'shows username on the homepage after Login' do
    joseph_user = User.find_by(username: "Joseph")
    expect(page).to have_content("Joseph")
    expect(current_path).to eq(user_url(joseph_user))
  end
  
end

feature 'logging out' do
  # background :each do 
  # 
  # end
  scenario 'begins with a Logout state' do 
    visit new_user_path
    expect(page).to have_content("Login")
    expect(page).to_not have_content("Logout")
  end
  scenario 'doesnt show username on the homepage after Logout' do 
    visit new_user_path
    user = User.create(username: 'Joseph',password: 'starwars')
    fill_in 'username', with: 'Joseph'
    fill_in 'password', with: 'starwars'
    click_button 'Login'
    click_button 'Logout'
    expect(page).to_not have_content("Joseph")
    expect(page).to have_content("Login")
  end
end
  