Feature: Web Automation with Behave

  @LoginSuccess
  Scenario: User successfully logs in with valid credentials (LoginSuccess)
    Given I open "https://www.tradehub.com.au/login"
    When I enter "valid_username" as Username
    And I enter "valid_password" as Password
    And I click on the 'Login' button
    Then I see Success Message is Visible

  @RegisterAccount
  Scenario: User registers a new account (RegisterAccount)
    Given I open "https://www.tradehub.com.au/register"
    When I enter "Furkan" as Name
    And I enter "Trade Business" as Business Type
    And I enter "Furkan's Plumbing" as Business Name
    And I enter "furkan@example.com" as Email
    And I enter "1234567890" as Phone
    And I enter "Plumbing" as Primary Trade
    And I enter "Sydney" as Suburb/Location
    And I enter "password123" as Password
    And I click on Register
    Then I see Activation Email Sent Message is Visible

  @ListAvailability
  Scenario: Business lists availability dates (ListAvailability)
    Given I open "https://www.tradehub.com.au/account"
    When I click on the "List Subcontracting Dates" button
    And I enter "2023-10-01" as Start Date
    And I enter "2023-10-05" as End Date
    And I enter "2 plumbers available Wed/Thu" as Availability Description
    And I click on the "Save Changes" button
    Then I see the updated availability dates displayed on the "Account" page

  @DeleteAvailability
  Scenario: Business deletes availability dates (DeleteAvailability)
    Given I open "https://www.tradehub.com.au/account"
    When I click on the "Delete" icon next to the saved availability date
    And I click on the "Confirm Deletion" button
    Then I do not see the deleted availability date displayed on the "Account" page