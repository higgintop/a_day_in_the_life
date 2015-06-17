require 'spec_helper'
require 'rails_helper'
require 'capybara/rspec'

feature "Users edits and deletes entries" do


  before do
    user = Fabricate(:user, name: "Jenny")
    journal = Fabricate(:journal, title: "Travelling", user: user)
    Fabricate(:entry, title: "Travelling to Spain", post: "Had lots of fun!", journal: journal)
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: "password1"
    click_button "Go!"
  end

  scenario "happy path editing a entry" do
    click_on "Journals"
    click_on "View"
    click_on "View Entry"
    # should now be on single entry page
    page.should have_content("Travelling to Spain")
    page.should have_content("Had lots of fun!")
    click_on "Edit Entry"
    field_labeled("Title").value.should == "Travelling to Spain"
    field_labeled("Post").value.should == "Had lots of fun!"
    fill_in "Post", with: "Had lots of fun in Spain!"
    click_on "Save Changes"
    page.should have_content("Had lots of fun in Spain!")
  end

  scenario "sad path editing an entry" do
    click_on "Journals"
    click_on "View"
    click_on "View Entry"
    # should now be on single entry page
    page.should have_content("Travelling to Spain")
    page.should have_content("Had lots of fun!")
    click_on "Edit Entry"
    field_labeled("Title").value.should == "Travelling to Spain"
    field_labeled("Post").value.should == "Had lots of fun!"
    fill_in "Post", with: " "
    click_on "Save Changes"
    page.should have_css(".flash-alert", text: "Please fix the errors below to continue.")
    page.should have_css(".help-block", text: "can't be blank")
  end

  scenario "deleting entry happy path"  do
    click_on "Journals"
    click_on "View"
    click_on "View Entry"
    # should now be on single entry page
    page.should have_content("Travelling to Spain")
    page.should have_content("Had lots of fun!")
    click_on "Delete Entry"
    page.should have_css(".flash-notice", text: "Travelling to Spain Entry has been deleted.")
  end
end



