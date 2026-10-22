Feature: Web Automation with Behave

  @LoginSuccess
  Scenario: User successfully logs in with valid credentials
    Given I open "https://www.tradehub.com.au/login"
    When I enter "valid_username" as Username
    And I enter "valid_password" as Password
    And I click on "Login" button
    Then I see "Welcome, valid_username!" message

  @RegisterAccount
  Scenario: User registers a new account with valid details (Duplicate)
    Given I open "https://www.tradehub.com.au/register"
    When I enter "Furkan" as Name
    And I enter "Trade Business" as Business Type
    And I enter "Furkan's Plumbing" as Business Name
    And I enter "furkan@example.com" as Email
    And I enter "1234567890" as Phone
    And I enter "123456" as Password
    And I enter "123456" as Confirm Password
    And I click on "Register" button
    Then I see "Registration successful!" message

  @PostJob
  Scenario: User posts a job and triggers ABN prompt (Duplicate)
    Given I open "https://www.tradehub.com.au/jobs/post"
    When I enter "Plumbing" as Job Type
    And I enter "1234567890" as Phone
    And I enter "123456" as Price
    And I click on "Post Job" button
    Then I see "Please enter your ABN" message

  @ListSubcontractingDates
  Scenario: Business lists subcontracting dates and integrates into Directory Search filter (Duplicate)
    Given I open "https://www.tradehub.com.au/account"
    When I click on "List Subcontracting Dates" button
    And I enter "2023-10-01" as Start Date
    And I enter "2023-10-05" as End Date
    And I click on "Save Changes" button
    Then I see "Availability dates saved successfully" message
    And I select the filter option to show only profiles with upcoming available dates as Filter
    Then I see only profiles with upcoming available dates displayed in the directory

  @SendMessages
  Scenario: User sends a message and sees the confirmation message (Duplicate)
    Given I open "https://www.tradehub.com.au/messages"
    When I select "Account A" as the sender
    And I select "Account B" as the recipient
    And I enter "Hello, this is a test message" as the message
    And I click on "Send" button
    Then I see the "Message sent successfully" message
    And I see the message "Hello, this is a test message" from "Account A"
    And I see the message "This is a reply" from "Account B"