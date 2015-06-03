require "rails_helper"

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
    click_on "Sign Up"
    page.should have_content("Welcome, Joe")
    User.last.tap do |user|
      user.name.should == "Joe"
      user.email.should == "joe@example.com"
    end
    pending
    signout
    signin_as "joe@example.com", "password1"
  end
end

