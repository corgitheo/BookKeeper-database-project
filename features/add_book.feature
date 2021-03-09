Feature: Add a new book
  
  As a reader
  So that I can keep track of my books
  I want to be able to add a new book to my library
  
Scenario: As a reader I want to be able to navigate from the home page to the new book form and add a book
  Given I am on the home page
  When I login with "test@test.com" and "123456"
  Then I should be on the users home page
  When I press "Add Book"
  Then I should be on the "New Book" page
  And I should see the "Title" field
  And I should see the "Isbn" field
  When I fill in "Title" with "1984"
  And I press "Create Book"
  Then I should be on the users home page
  And I should see "1984 was added."
  