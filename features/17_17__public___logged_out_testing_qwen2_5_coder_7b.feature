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
  Scenario: User posts a job and triggers ABN prompt
    Given I open "https://www.tradehub.com.au/jobs/post"
    When I enter "Plumbing" as Job Type
    And I enter "123 Main St" as Address
    And I enter "123456" as Budget
    And I click on "Post Job" button
    Then I see "Please provide ABN for verification" message

  @ListAvailability
  Scenario: User lists availability dates and integrates into Directory Search filter
    Given I open "https://www.tradehub.com.au/account"
    When I click on "List Subcontracting Dates" button
    And I enter "2023-10-01" as Start Date
    And I enter "2023-10-05" as End Date
    And I click on "Save Changes" button
    Then I see "Availability dates saved successfully" message
    And I select "Show only profiles with upcoming available dates" as Filter
    Then I see only profiles with upcoming available dates displayed in the directory

  @SendMessages
  Scenario: User sends messages and verifies message content
    Given I navigate to the "Messages" page
    When I select "Account A" as the sender
    And I select "Account B" as the recipient
    And I enter "Hello, this is a test message" as the message
    And I click on the "Send" button
    Then I see the "Message sent successfully" message
    And I see the message "Hello, this is a test message" from "Account A"
    And I see the message "This is a reply" from "Account B"

  @LoginSuccess
  Scenario: User successfully logs in with valid credentials
    BrowserSteps I open "https://www.tradehub.com.au/login"
    ActionSteps I enter "<RANDOM:8>" as Username
    ActionSteps I enter "<RANDOM:8>" as Password
    ActionSteps I click on Login
    ValidationSteps I see Login Success Message is Visible

  @RegisterAccount
  Scenario: User registers a new account with valid details
    BrowserSteps I open "https://www.tradehub.com.au/register"
    ActionSteps I enter "Furkan" as Name
    ActionSteps I enter "Trade Business" as Business Type
    ActionSteps I enter "Furkan's Plumbing" as Business Name
    ActionSteps I enter "furkan@example.com" as Email
    ActionSteps I enter "12345678" as Phone
    ActionSteps I enter "Plumbing" as Primary Trade
    ActionSteps I enter "Sydney" as Suburb/Location
    ActionSteps I enter "password123" as Password
    ActionSteps I click on Register
    ValidationSteps I see Registration Success Message is Visible

  @PostJob
  Scenario: User posts a job and triggers ABN prompt
    BrowserSteps I open "https://www.tradehub.com.au/jobs/post"
    ActionSteps I enter "Plumbing" as Job Type
    ActionSteps I enter "Sydney" as Location
    ActionSteps I enter "<RANDOM:1000>" as Job Description
    ActionSteps I click on Post Job
    ValidationSteps I see ABN Prompt is Visible

  @ListAvailability
  Scenario: User lists availability dates and integrates into Directory Search filter
    BrowserSteps I open "https://www.tradehub.com.au/account"
    ActionSteps I click on List Subcontracting Dates
    ActionSteps I enter "2023-10-01" as Start Date
    ActionSteps I enter "2023-10-05" as End Date
    ActionSteps I click on Save Changes
    ValidationSteps I see the saved availability dates displayed on the "Account" page
    ActionSteps I select the filter option to show only profiles with upcoming available dates in the directory
    ValidationSteps I see only profiles with upcoming available dates displayed in the directory

  @MessageExchange
  Scenario: User sends and receives messages in the Messages page
    BrowserSteps I navigate to the "Messages" page
    ActionSteps I select Account A as the sender
    ActionSteps I select Account B as the recipient
    ActionSteps I enter "Hello, this is a test message" as the message
    ActionSteps I click on the "Send" button
    ValidationSteps I see the "Message sent successfully" message
    ValidationSteps I see the message "Hello, this is a test message" from Account A
    ValidationSteps I see the message "This is a reply" from Account B

