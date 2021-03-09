Given("I am on the home page") do
  visit root_path
end

Then("I should be on the {string} page") do |string|
  expect(page).to have_content(string)
end

Then("I should see the {string} field") do |string|
  expect(page).to have_field(string)
end

Given("I am on the login page") do
  visit new_user_session_path
end

And /^I fill in "(.*)" with "(.*)"$/ do |field, value|
  fill_in(field, :with => value)
end

And /^I press "(.*)"$/ do |button|
  click_on button
end

When("I login with {string} and {string}") do |string, string2|
  visit new_user_session_path
  User.create(:name => "#{string}", :email => "test@test.com", :password => "#{string2}", :password_confirmation => "#{string2}")
  fill_in "Email", with: string
  fill_in "Password", with: string2
  click_button "Log in"
end

Then("I should be on the users home page") do
  page.body.should have_content("Library")
end

Then("I should see {string}") do |string|
  page.body.should have_content(string)
end


Then("I click the {string} picture") do |string|
  find(:xpath, "//a/img[@alt=#{string}]/..").click 
end



