Feature: Web Automation with Behave

  @LoginSuccess
  Scenario: User successfully logs in with valid credentials
    Given I open the login page
    When I enter the username
    And I enter the password
    And I click on the login button
    Then I see the welcome message

  @RegisterAccount
  Scenario: User successfully registers a new account
    Given I open the registration page
    When I enter the name
    And I enter the business type
    And I enter the business name
    And I enter the email
    And I enter the phone number
    And I enter the primary trade
    And I enter the suburb/location
    And I enter the password
    And I click on the register button
    Then I see the registration successful message

  @ABNVerification
  Scenario: User is prompted to enter ABN after posting a job
    Given I open the post job page
    When I enter the job title
    And I enter the job description
    And I click on the post job button
    Then I see the ABN prompt message

  @AvailabilityListing
  Scenario: User lists availability dates and they appear in the directory
    Given I open the account page
    When I click on the add new date button
    And I enter the availability dates
    And I click on the save changes button
    Then I see the saved availability dates displayed on the account page
    When I navigate to the directory page
    And I select the filter option to show only profiles with upcoming available dates
    Then I see only profiles with upcoming available dates displayed in the directory page

  @MessageSending
  Scenario: User sends a message and receives a confirmation
    Given I navigate to the messages page
    When I select the sender
    And I select the recipient
    And I enter the message
    And I click on the send button
    Then I see the message sent successfully message