require 'spec_helper'
require 'rails_helper'
require 'capybara/rspec'

feature "User Signs Up" do

  background do
    visit root_path
    click_on "Sign Up"
  end

  scenario "Happy Path" do
    fill_in "Name", with: "Joe"
    fill_in "Email", with: "joe@example.com"
    fill_in "Password", with: "password1"
    fill_in "Password confirmation", with: "password1"
    click_button "Go!"
    page.should have_css(".journals_btn")
  end
end

