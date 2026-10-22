Feature: Web Automation with Behave

  @LoginSuccess
  Scenario: User successfully logs in with valid credentials
    Given I open "https://www.tradehub.com.au/login"
    When I enter "valid_username" as Username
    And I enter "valid_password" as Password
    And I click on "Login" button
    Then I see "Welcome, valid_username!" message

  @RegisterAccount
  Scenario: User registers a new account with valid details
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
  Scenario: User posts a job and is prompted for ABN
    Given I open "https://www.tradehub.com.au/jobs/post"
    When I enter "Plumbing" as Job Type
    And I enter "Sydney" as Location
    And I enter "1000" as Budget
    And I click on "Post Job" button
    Then I see "Please provide your ABN" message

  @PostTender
  Scenario: User posts a tender and is prompted for ABN
    Given I open "https://www.tradehub.com.au/tenders/post"
    When I enter "3 Townhouse Development" as Tender Title
    And I enter "Sydney" as Location
    And I enter "100000" as Budget
    And I click on "Post Tender" button
    Then I see "Please provide your ABN" message

  @ListAvailability
  Scenario: User lists availability dates and is prompted for ABN
    Given I open "https://www.tradehub.com.au/account/list-availability"
    When I enter "2023-10-01" as Start Date
    And I enter "2023-10-31" as End Date
    And I click on "List Availability" button
    Then I see "Please provide your ABN" message

  @FilterDirectory
  Scenario: User filters directory to show only profiles with upcoming available dates
    Given I open "https://www.tradehub.com.au/directory"
    When I select "Show only profiles with upcoming available dates" as Filter
    Then I see only profiles with upcoming available dates displayed in the directory

  @SendMessages
  Scenario: User sends a message and sees confirmation
    Given I navigate to the "Messages" page
    When I select "Account A" as the sender
    And I select "Account B" as the recipient
    And I enter "Hello, this is a test message" as the message
    And I click on the "Send" button
    Then I see the "Message sent successfully" message