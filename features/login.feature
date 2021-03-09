Feature: Login to BookKeeper
  
  As a reader
  So that I can view my library
  I need to be able to login to the site

Scenario: login with valid credentials
  Given I am on the login page
  When I login with "test@test.com" and "123456"
  Then I should be on the users home page
  And I should see "Signed in successfully"