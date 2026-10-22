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
    And I enter "FurkanTech" as Business Name
    And I enter "furkan@example.com" as Email
    And I enter "1234567890" as Phone
    And I enter "Plumbing" as Primary Trade
    And I enter "Sydney" as Suburb/Location
    And I enter "password123" as Password
    And I click on "Register" button
    Then I see "Registration successful!" message

  @ABNVerification
  Scenario: User is prompted to enter ABN after posting a job
    Given I open "https://www.tradehub.com.au/jobs/post"
    When I enter "Job Title" as Job Title
    And I enter "Job Description" as Job Description
    And I click on "Post Job" button
    Then I see "Please enter your ABN" message

  @AvailabilityListing
  Scenario: User lists availability dates and verifies listing in directory
    Given I open "https://www.tradehub.com.au/account"
    When I click on "Add New Date" button
    And I enter "2023-12-25" as Availability Dates
    And I enter "Available for plumbing work" as Availability Description
    And I click on "Save Changes" button
    Then I see the updated availability description displayed on the "Account" page
    When I navigate to the "Directory" page
    And I select the filter option to show only profiles with upcoming available dates as Filter
    Then I see only profiles with upcoming available dates displayed in the directory

  @MessageSending
  Scenario: User sends a message and verifies receipt
    Given I navigate to the "Messages" page
    When I select "Account A" as the sender
    And I select "Account B" as the recipient
    And I enter "Hello, this is a test message" as the message
    And I click on the "Send" button
    Then I see the "Message sent successfully" message
    And I see the message "Hello, this is a test message" from "Account A"

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

  @ABNVerification
  Scenario: User is prompted to enter ABN after posting a job
    Given I open "https://www.tradehub.com.au/jobs/post"
    When I enter "Job Title" as Job Title
    And I enter "Job Description" as Job Description
    And I click on Post Job
    Then I see ABN Verification Prompt is Visible

  @AvailabilityListing
  Scenario: User lists availability dates and verifies listing
    Given I open "https://www.tradehub.com.au/account"
    When I click on the "List Subcontracting Dates" button
    And I enter "2023-10-01" as Availability Dates
    And I click on the "Save Changes" button
    Then I see the saved availability dates displayed on the "Account" page

  @AvailabilityFilter
  Scenario: User filters directory to show only profiles with upcoming available dates
    Given I open "https://www.tradehub.com.au/directory"
    When I select the filter option to show only profiles with upcoming available dates as Filter
    Then I see only profiles with upcoming available dates displayed in the directory

  @MessageSending
  Scenario: User sends a message and verifies receipt
    Given I navigate to the "Messages" page
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
    And I see an email with subject "Activate your TradeHub account"

  @PostJob
  Scenario: User posts a job and triggers ABN prompt
    Given I open "https://www.tradehub.com.au/jobs/post"
    When I enter "Plumbing" as Job Type
    And I enter "1234567890" as Phone
    And I enter "123456" as Price
    And I click on "Post Job" button
    Then I see "Please provide your ABN" message

  @ListSubcontractingDates
  Scenario: User lists subcontracting dates and sees them in directory filter
    Given I open "https://www.tradehub.com.au/account"
    When I click on "Add New Date" button
    And I enter "2023-12-01" as Availability Dates
    And I click on "Save Changes" button
    When I select the filter option to show only profiles with upcoming available dates as Filter
    Then I see the test business displayed in the directory

  @SendMessages
  Scenario: User sends a message and sees it in the messages page
    Given I open "https://www.tradehub.com.au/messages"
    When I select "Account A" as the sender
    And I select "Account B" as the recipient
    And I enter "Hello, this is a test message" as the message
    And I click on "Send" button
    Then I see the "Message sent successfully" message
    And I see the message "Hello, this is a test message" from "Account A"

  @LoginSuccess
  Scenario: User successfully logs in with valid credentials
    Given I open "https://www.tradehub.com.au/login"
    When I enter "testuser" as Username
    And I enter "password123" as Password
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

  @ListAvailability
  Scenario: Business lists availability dates
    Given I open "https://www.tradehub.com.au/account"
    When I click on the "List Subcontracting Dates" button
    And I enter "2023-10-01" as Start Date
    And I enter "2023-10-31" as End Date
    And I enter "2 plumbers available Wed/Thu" as Availability Description
    And I click on the "Save Changes" button
    Then I see the updated availability dates displayed on the "Account" page

  @FilterDirectory
  Scenario: User filters directory to show only profiles with upcoming available dates
    Given I open "https://www.tradehub.com.au/directory"
    When I select the filter option to show only profiles with upcoming available dates as Filter
    Then I see only profiles with upcoming available dates displayed in the directory

  @SendMessages
  Scenario: User sends a message
    Given I open "https://www.tradehub.com.au/messages"
    When I select Account A as the sender
    And I select Account B as the recipient
    And I enter "Hello, this is a test message" as the message
    And I click on the "Send" button
    Then I see the "Message sent successfully" message

