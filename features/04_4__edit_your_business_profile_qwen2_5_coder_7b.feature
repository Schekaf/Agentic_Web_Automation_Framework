Feature: Web Automation with Behave

  @LoginSuccess
  Scenario: User successfully logs in with valid credentials (LoginSuccess)
    Given I open "https://www.tradehub.com.au/login"
    When I enter "valid_username" as Username
    And I enter "valid_password" as Password
    And I click on "Login" button
    Then I see "Welcome, valid_username!" message

  @RegisterAccount
  Scenario: User registers a new account with valid details (RegisterAccount)
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
  Scenario: User posts a job and triggers ABN prompt (PostJob)
    Given I open "https://www.tradehub.com.au/jobs/post"
    When I enter "Plumbing" as Job Type
    And I enter "1234567890" as Phone
    And I enter "123456" as Price
    And I click on "Post Job" button
    Then I see "Please enter your ABN" message

  @ListAvailability
  Scenario: User lists availability dates and integrates into directory search (ListAvailability)
    Given I open "https://www.tradehub.com.au/account"
    When I click on "Add New Date" button
    And I enter "2023-10-01" as Availability Dates
    And I click on "Save Changes" button
    Then I see the saved availability dates displayed on the "Account" page
    When I select the filter option to show only profiles with upcoming available dates in the directory
    Then I see only profiles with upcoming available dates displayed in the directory

  @SendMessages
  Scenario: User sends messages between accounts (SendMessages)
    Given I navigate to the "Messages" page
    When I select Account A as the sender
    And I select Account B as the recipient
    And I enter "Hello, this is a test message" as the message
    And I click on the "Send" button
    Then I see the "Message sent successfully" message
    And I see the message "Hello, this is a test message" from Account A
    And I see the message "This is a reply" from Account B

  @PostJob
  Scenario: User posts a job and is prompted for ABN (PostJob)
    Given I open "https://www.tradehub.com.au/jobs/post"
    When I enter "Plumbing" as Job Type
    And I enter "Sydney" as Location
    And I enter "1000" as Budget
    And I click on "Post Job" button
    Then I see "Please provide your ABN to post this job" message

  @ListSubcontractingDates
  Scenario: Business lists subcontracting dates and it appears in directory search (ListSubcontractingDates)
    Given I open "https://www.tradehub.com.au/account"
    When I click on "List Subcontracting Dates" button
    And I enter "2023-10-01" as Start Date
    And I enter "2023-10-05" as End Date
    And I click on "Save Changes" button
    Then I see "2023-10-01 to 2023-10-05" displayed in the directory search filter

  @MessageCommunication
  Scenario: User sends and receives messages (MessageCommunication)
    Given I open "https://www.tradehub.com.au/messages"
    When I select Account A as the sender
    And I select Account B as the recipient
    And I enter "Hello, this is a test message" as the message
    And I click on the "Send" button
    Then I see the "Message sent successfully" message
    And I see the message "Hello, this is a test message" from Account A
    And I see the message "This is a reply" from Account B