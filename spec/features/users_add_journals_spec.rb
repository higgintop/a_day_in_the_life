require 'spec_helper'
require 'rails_helper'
require 'capybara/rspec'

feature "Users add tracks" do

  scenario "happy path creating a journal" do
    signin_as Fabricate(:user)
    visit journals_path
    click_on "Add New Journal"
    fill_in "Title", with: "Movie Reviews"
    click_on "Create Journal"
    page.should have_css(".notice", text: "Movie Reviews Journal has been created")
    current_path.should == journals_path
    within("ul#journals") do
      page.should have_content("Movie Reviews")
    end
  end

  scenario "sad path creating a journal" do
    signin_as Fabricate(:user)
    visit new_journal_path
    fill_in "Title", with: "   "
    click_on "Create Journal"
    page.should have_css(".alert", text: "Please fix the errors below to continue.")
    page.should have_css(".journal_title .error", text: "can't be blank")
    field_labeled("Title").value.should == "   "
  end
end

