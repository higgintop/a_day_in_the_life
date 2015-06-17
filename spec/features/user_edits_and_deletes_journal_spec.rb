require 'spec_helper'
require 'rails_helper'
require 'capybara/rspec'

feature "Users edits and deletes tracks" do


  before do
    user = Fabricate(:user, name: "Jenny")
    Fabricate(:journal, title: "Travelling", user: user)
    Fabricate(:journal, title: "Travelling to Spain", user: user)
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: "password1"
    click_button "Go!"
  end

  scenario "happy path editing a journal" do
    click_on "Journals"
    click_on "Edit"
    field_labeled("Title").value.should == "Travelling"
    fill_in "Title", with: "Travelling to Africa"
    click_on "Edit Journal"
    page.should have_css(".flash-notice", text: "Travelling to Africa Journal was updated successfully")
    within("div.journals-container") do
      page.should have_content("Travelling to Africa")
    end
  end

  scenario "sad path editing a journal" do
    click_on "Journals"
    click_on "Edit"
    field_labeled("Title").value.should == "Travelling"
    fill_in "Title", with: " "
    click_on "Edit Journal"
    page.should have_css(".flash-alert", text: "Please fix the errors below to continue.")
    page.should have_css(".help-block", text: "can't be blank")
  end

  scenario "editing by changing title to a duplicate journal title" do
    click_on "Journals"
    click_on "Edit"
    field_labeled("Title").value.should == "Travelling"
    fill_in "Title", with: "Travelling to Spain"
    click_on "Edit Journal"
    page.should have_css(".flash-alert", text: "Please fix the errors below to continue.")
    page.should have_css(".help-block", text: "has already been taken")
  end

  scenario "deleting journal happy path"  do
    click_on "Journals"
    click_on "Delete"
    page.should have_css(".flash-notice", text: "Travelling Journal has been deleted.")
  end
end


