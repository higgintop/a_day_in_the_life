def signin_as(user)
  visit new_user_session_path
  fill_in "Email", with: user.email
  fill_in "Password", with: "password1"
  click_on "Sign In"
  page.should have_content("Welcome back")
end

