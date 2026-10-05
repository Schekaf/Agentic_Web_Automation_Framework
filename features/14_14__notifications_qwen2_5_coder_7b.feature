Feature: Web Automation with Behave

  @JobApplicationNotification
  Scenario: Generate job application notification between two accounts
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    And I click on "Login"
    And I enter "<RANDOM:8>" as Username
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    And I click on "Post Job"
    And I enter "Job Title" in "Job Title" field
    And I enter "Job Description" in "Job Description" field
    And I click on "Post Job"
    And I click on "Apply for Job"
    And I click on "Send Application"
    Then I see "Job Application Notification" is visible

  @SelectionNotification
  Scenario: Generate selection notification between two accounts
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    And I click on "Login"
    And I enter "<RANDOM:8>" as Username
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    And I click on "Post Job"
    And I enter "Job Title" in "Job Title" field
    And I enter "Job Description" in "Job Description" field
    And I click on "Post Job"
    And I click on "Apply for Job"
    And I click on "Send Application"
    And I click on "Select Job"
    Then I see "Selection Notification" is visible

  @AcceptanceNotification
  Scenario: Generate acceptance notification between two accounts
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    And I click on "Login"
    And I enter "<RANDOM:8>" as Username
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    And I click on "Post Job"
    And I enter "Job Title" in "Job Title" field
    And I enter "Job Description" in "Job Description" field
    And I click on "Post Job"
    And I click on "Apply for Job"
    And I click on "Send Application"
    And I click on "Select Job"
    And I click on "Accept Job"
    Then I see "Acceptance Notification" is visible

  @TenderQuoteNotification
  Scenario: Generate tender quote notification between two accounts
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    And I click on "Login"
    And I enter "<RANDOM:8>" as Username
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    And I click on "Post Tender"
    And I enter "Tender Title" in "Tender Title" field
    And I enter "Tender Description" in "Tender Description" field
    And I click on "Post Tender"
    And I click on "Submit Quote"
    And I enter "Quote Amount" in "Quote Amount" field
    And I click on "Submit Quote"
    Then I see "Tender Quote Notification" is visible

  @MessageNotification
  Scenario: Generate message notification between two accounts
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    And I click on "Login"
    And I enter "<RANDOM:8>" as Username
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    And I click on "Send Message"
    And I enter "Recipient Username" in "Recipient Username" field
    And I enter "Message Content" in "Message Content" field
    And I click on "Send Message"
    Then I see "Message Notification" is visible

  @AvailabilityActivityNotification
  Scenario: Generate availability activity notification between two accounts
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    And I click on "Login"
    And I enter "<RANDOM:8>" as Username
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    And I click on "List Subcontracting Dates"
    And I enter "Date" in "Date" field
    And I click on "Submit"
    Then I see "Availability Activity Notification" is visible

  @JobApplicationNotification
  Scenario: Check notifications appear for job application
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    And I click on "Login"
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    And I click on "Post Job"
    And I enter "Job Title" in "Job Title" field
    And I enter "Job Description" in "Job Description" field
    And I click on "Post Job"
    Then I see "Job posted successfully" is visible

  @SelectionNotification
  Scenario: Check notifications appear for selection
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    And I click on "Login"
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    And I click on "Apply for Job"
    And I enter "Application Message" in "Application Message" field
    And I click on "Submit Application"
    Then I see "Application submitted successfully" is visible

  @AcceptanceNotification
  Scenario: Check notifications appear for acceptance
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    And I click on "Login"
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    And I click on "Accept Job"
    Then I see "Job accepted successfully" is visible

  @TenderQuoteNotification
  Scenario: Check notifications appear for tender quote
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    And I click on "Login"
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    And I click on "Post Tender"
    And I enter "Tender Title" in "Tender Title" field
    And I enter "Tender Description" in "Tender Description" field
    And I click on "Post Tender"
    Then I see "Tender posted successfully" is visible

  @MessageNotification
  Scenario: Check notifications appear for message
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    And I click on "Login"
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    And I click on "Send Message"
    And I enter "Message Content" in "Message Content" field
    And I click on "Send"
    Then I see "Message sent successfully" is visible

  @AvailabilityActivityNotification
  Scenario: Check notifications appear for availability activity
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    And I click on "Login"
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    And I click on "List Subcontracting Dates"
    And I enter "Available Dates" in "Available Dates" field
    And I click on "Submit"
    Then I see "Subcontracting dates listed successfully" is visible

  @job_application
  Scenario: Check notification wording makes sense for job application
    Given I open the TradeHub website
    When I apply for a job
    And I submit the application
    Then I receive a notification with the correct wording

  @selection
  Scenario: Check notification wording makes sense for selection
    Given I open the TradeHub website
    When I am selected for a job
    Then I receive a notification with the correct wording

  @acceptance
  Scenario: Check notification wording makes sense for acceptance
    Given I open the TradeHub website
    When I accept a job
    Then I receive a notification with the correct wording

  @tender_quote
  Scenario: Check notification wording makes sense for tender quote
    Given I open the TradeHub website
    When I submit a tender quote
    Then I receive a notification with the correct wording

  @message
  Scenario: Check notification wording makes sense for message
    Given I open the TradeHub website
    When I send a message
    Then I receive a notification with the correct wording

  @availability_activity
  Scenario: Check notification wording makes sense for availability activity
    Given I open the TradeHub website
    When I list my availability
    Then I receive a notification with the correct wording

  @JobApplicationNotification
  Scenario: Check clicking on job application notification takes to correct item
    Given I open the TradeHub website
    When I receive a job application notification
    And I click on the job application notification
    Then I am redirected to the correct job application item

  @SelectionNotification
  Scenario: Check clicking on selection notification takes to correct item
    Given I open the TradeHub website
    When I receive a selection notification
    And I click on the selection notification
    Then I am redirected to the correct selection item

  @AcceptanceNotification
  Scenario: Check clicking on acceptance notification takes to correct item
    Given I open the TradeHub website
    When I receive an acceptance notification
    And I click on the acceptance notification
    Then I am redirected to the correct acceptance item

  @TenderQuoteNotification
  Scenario: Check clicking on tender quote notification takes to correct item
    Given I open the TradeHub website
    When I receive a tender quote notification
    And I click on the tender quote notification
    Then I am redirected to the correct tender quote item

  @MessageNotification
  Scenario: Check clicking on message notification takes to correct item
    Given I open the TradeHub website
    When I receive a message notification
    And I click on the message notification
    Then I am redirected to the correct message item

  @AvailabilityActivityNotification
  Scenario: Check clicking on availability activity notification takes to correct item
    Given I open the TradeHub website
    When I receive an availability activity notification
    And I click on the availability activity notification
    Then I am redirected to the correct availability activity item

  @JobApplicationNotification
  Scenario: Check read/unread behavior for job application notification
    Given I open the TradeHub website
    When I apply for a job
    And I receive a job application notification
    Then I see the job application notification as unread
    When I mark the job application notification as read
    Then I see the job application notification as read

  @SelectionNotification
  Scenario: Check read/unread behavior for selection notification
    Given I open the TradeHub website
    When I am selected for a job
    And I receive a selection notification
    Then I see the selection notification as unread
    When I mark the selection notification as read
    Then I see the selection notification as read

  @AcceptanceNotification
  Scenario: Check read/unread behavior for acceptance notification
    Given I open the TradeHub website
    When I accept a job
    And I receive an acceptance notification
    Then I see the acceptance notification as unread
    When I mark the acceptance notification as read
    Then I see the acceptance notification as read

  @TenderQuoteNotification
  Scenario: Check read/unread behavior for tender quote notification
    Given I open the TradeHub website
    When I submit a tender quote
    And I receive a tender quote notification
    Then I see the tender quote notification as unread
    When I mark the tender quote notification as read
    Then I see the tender quote notification as read

  @MessageNotification
  Scenario: Check read/unread behavior for message notification
    Given I open the TradeHub website
    When I receive a message
    And I receive a message notification
    Then I see the message notification as unread
    When I mark the message notification as read
    Then I see the message notification as read

  @AvailabilityActivityNotification
  Scenario: Check read/unread behavior for availability activity notification
    Given I open the TradeHub website
    When I list my availability
    And I receive an availability activity notification
    Then I see the availability activity notification as unread
    When I mark the availability activity notification as read
    Then I see the availability activity notification as read

  @JobApplication
  Scenario: Check notification count updates for job application
    Given I open the TradeHub website
    When I apply for a job
    Then I see the notification count updates

  @Selection
  Scenario: Check notification count updates for selection
    Given I open the TradeHub website
    When I am selected for a job
    Then I see the notification count updates

  @Acceptance
  Scenario: Check notification count updates for acceptance
    Given I open the TradeHub website
    When I accept a job
    Then I see the notification count updates

  @TenderQuote
  Scenario: Check notification count updates for tender quote
    Given I open the TradeHub website
    When I submit a tender quote
    Then I see the notification count updates

  @Message
  Scenario: Check notification count updates for message
    Given I open the TradeHub website
    When I send a message
    Then I see the notification count updates

  @AvailabilityActivity
  Scenario: Check notification count updates for availability activity
    Given I open the TradeHub website
    When I list my availability
    Then I see the notification count updates

