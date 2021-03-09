Feature: Lend an exisiting book
  
  As a reader
  So that I can keep track of what books I've lent to others
  I want to be able to specify the person I lent a particular book to
  
Scenario: As a reader I want to be able to lend a book
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
  When I click the "1984" picture
  Then I should see "ISBN"
  When I press "Edit"
  Then I should see the "Lent" field
  When I fill in "Lent" with "test"
  And I press "Update Book"
  Then I should see "Lent To:"
  Then I should see "test"
  When I press "Back"
  Then I should see "Lent To: test"