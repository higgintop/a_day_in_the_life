require 'spec_helper'
require 'rails_helper'
require 'capybara/rspec'

feature "Users add tracks" do


  before do
    user = Fabricate(:user, name: "Jenny")
    Fabricate(:journal, title: "Travelling", user: user)
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: "password1"
    click_button "Go!"
  end

  scenario "happy path creating a journal" do
    click_on "Journals"
    click_on "Add New Journal"
    fill_in "Title", with: "Movie Reviews"
    click_on "Create Journal"
    page.should have_css(".flash-notice", text: "The Movie Reviews Journal has been created")
    within("div.journals-container") do
      page.should have_content("Movie Reviews")
    end
  end

  scenario "sad path creating a journal" do
    click_on "Journals"
    click_on "Add New Journal"
    fill_in "Title", with: "   "
    click_on "Create Journal"
    page.should have_css(".flash-alert", text: "Please fix the errors below to continue.")
    page.should have_css(".help-block", text: "can't be blank")
    field_labeled("Title").value.should == "   "
  end

  scenario "creating a duplicate journal" do
    click_on "Journals"
    click_on "Add New Journal"
    fill_in "Title", with: "Travelling"
    click_on "Create Journal"
    page.should have_css(".flash-alert", text: "Please fix the errors below to continue.")
    page.should have_css(".help-block", text: "has already been taken")
  end
end

