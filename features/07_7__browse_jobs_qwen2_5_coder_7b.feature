Feature: Web Automation with Behave

  @LoginSuccess
  Scenario: User successfully logs in with valid credentials
    Given I open "https://www.tradehub.com.au/login"
    When I enter "valid_username" as Username
    And I enter "valid_password" as Password
    And I click on "Login" button
    Then I see "Welcome, valid_username!" message

  @RegisterAccount
  Scenario: User successfully registers a new account
    Given I open "https://www.tradehub.com.au/register"
    When I enter "Furkan" as Name
    And I enter "Trade Business" as Business Type
    And I enter "Furkan's Plumbing" as Business Name
    And I enter "furkan@example.com" as Email
    And I enter "1234567890" as Phone
    And I enter "Plumbing" as Primary Trade
    And I enter "Sydney" as Suburb/Location
    And I enter "password123" as Password
    And I click on "Register" button
    Then I see "Registration successful!" message

  @PostJob
  Scenario: User posts a job and triggers ABN prompt
    Given I open "https://www.tradehub.com.au/jobs/post"
    When I enter "Plumbing job" as Job Title
    And I enter "Sydney" as Location
    And I enter "100" as Budget
    And I click on "Post Job" button
    Then I see "Please enter your ABN" message

  @ListSubcontractingDates
  Scenario: Business lists subcontracting dates and filters directory
    Given I open "https://www.tradehub.com.au/account"
    When I click on "List Subcontracting Dates" button
    And I enter "2023-10-01" as Start Date
    And I enter "2023-10-05" as End Date
    And I click on "Save Changes" button
    Then I see "Availability dates saved successfully" message
    When I select the filter option to show only profiles with upcoming available dates as Filter
    Then I see only profiles with upcoming available dates displayed in the directory

  @SendMessages
  Scenario: User sends messages and verifies recipient and content
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
    Given I open "https://www.tradehub.com.au/login"
    When I enter "valid_username" as Username
    And I enter "valid_password" as Password
    And I click on Login
    Then I see Success Message is Visible

  @RegisterAccount
  Scenario: User registers a new account with valid details
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

  @PostJob
  Scenario: User posts a job and triggers ABN prompt
    Given I open "https://www.tradehub.com.au/jobs/post"
    When I enter "Plumbing" as Job Type
    And I enter "Sydney" as Location
    And I enter "1000" as Budget
    And I click on Post Job
    Then I see ABN Prompt is Visible

  @ListAvailability
  Scenario: User lists availability dates and integrates into Directory Search filter
    Given I open "https://www.tradehub.com.au/account"
    When I click on the "List Subcontracting Dates" button
    And I enter "2023-10-01" as Start Date
    And I enter "2023-10-05" as End Date
    And I click on the "Save Changes" button
    Then I see the saved availability dates displayed on the "Account" page
    And I select the filter option to show only profiles with upcoming available dates as Filter
    Then I see only profiles with upcoming available dates displayed in the directory

  @MessageExchange
  Scenario: User sends and receives messages in the Messages page
    Given I open "https://www.tradehub.com.au/messages"
    When I select Account A as the sender
    And I select Account B as the recipient
    And I enter "Hello, this is a test message" as the message
    And I click on the "Send" button
    Then I see the "Message sent successfully" message
    And I see the message "Hello, this is a test message" from Account A
    And I see the message "This is a reply" from Account B

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
    And I enter "123456" as Job Description
    And I click on "Post Job" button
    Then I see "Please provide ABN" message

  @ListAvailability
  Scenario: Business lists availability dates and integrates into Directory Search filter
    Given I open "https://www.tradehub.com.au/account"
    When I click on "List Subcontracting Dates" button
    And I enter "2023-10-01" as Start Date
    And I enter "2023-10-05" as End Date
    And I click on "Save Changes" button
    Then I see "Availability dates saved successfully" message
    And I see "Show only profiles with upcoming available dates" option in Directory Search filter

  @SendMessages
  Scenario: User sends messages between accounts and verifies message content
    Given I navigate to the "Messages" page
    When I select "Account A" as the sender
    And I select "Account B" as the recipient
    And I enter "Hello, this is a test message" as the message
    And I click on the "Send" button
    Then I see the "Message sent successfully" message
    And I see the message "Hello, this is a test message" from "Account A"
    And I see the message "This is a reply" from "Account B"

