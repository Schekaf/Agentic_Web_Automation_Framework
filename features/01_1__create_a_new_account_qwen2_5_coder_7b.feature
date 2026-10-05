Feature: Web Automation with Behave

  @UI
  Scenario: Visit TradeHub homepage
    Given I open "https://www.tradehub.com.au/register"
    Then I see "TradeHub" in the title

  @UI
  Scenario: Click on create/register account option
    When I click on "Create Account"
    Then I see "Register" in the title

  @UI
  Scenario: Create a new Trade Business account
    And I select "Trade Business" as "Account Type"
    Then I see "Trade Business" selected as "Account Type"

  @UI
  Scenario: Enter valid name
    And I enter "Furkan" as "Name"
    Then I see "Furkan" in the "Name" field

  @UI
  Scenario: Enter valid business name
    And I enter "ABC Plumbing" as "Business Name"
    Then I see "ABC Plumbing" in the "Business Name" field

  @UI
  Scenario: Enter valid email address
    And I enter "furkan@example.com" as "Email"
    Then I see "furkan@example.com" in the "Email" field

  @RegisterAccount
  Scenario: Enter valid phone number
    Given I open "{url}"
    When I enter "{text}" as Phone Number
    Then I see "Phone Number is valid" is visible

  @RegisterAccount
  Scenario: Select valid primary trade
    Given I open "{url}"
    When I select "{option}" as Primary Trade
    Then I see "{option}" is selected as Primary Trade

  @RegisterAccount
  Scenario: Enter valid suburb/location
    Given I open "{url}"
    When I enter "{text}" as Suburb/Location
    Then I see "{text}" in Suburb/Location Values

  @RegisterAccount
  Scenario: Create valid password
    Given I open "{url}"
    When I enter "{text}" as Password
    Then I see "Password is valid" is visible

  @RegisterAccount
  Scenario: Accept terms and conditions
    Given I open "{url}"
    When I click on Accept Terms and Conditions
    Then I see "Terms and Conditions are accepted" is visible

  @RegisterAccount
  Scenario: Complete account registration
    Given I open "{url}"
    When I enter "{text}" as Name
    When I enter "{text}" as Business Name
    When I enter "{text}" as Email
    When I enter "{text}" as Phone Number
    When I select "{option}" as Primary Trade
    When I enter "{text}" as Suburb/Location
    When I enter "{text}" as Password
    When I click on Accept Terms and Conditions
    When I click on Complete Registration
    Then I see "Registration successful" is visible

  @CreateAccount
  Scenario: Check if instructions are easy to understand
    Given I open "{url}"
    When I click on "Instructions"
    Then I see "Instructions are easy to understand" is visible

  @CreateAccount
  Scenario: Check if required fields are clearly identified
    Given I open "{url}"
    When I click on "Register"
    Then I see "Required fields are clearly identified" is visible

  @CreateAccount
  Scenario: Check if incorrect fields show useful error messages
    Given I open "{url}"
    When I enter "<RANDOM:8>" as Name
    And I click on "Register"
    Then I see "Invalid Name" is visible

  @CreateAccount
  Scenario: Check if primary trade selection works correctly
    Given I open "{url}"
    When I select "{option}" as Primary Trade
    Then I see "{option}" is selected as Primary Trade

  @CreateAccount
  Scenario: Check if location/suburb search works correctly
    Given I open "{url}"
    When I enter "{text}" as Suburb
    And I click on "Search"
    Then I see "{text}" in Suburb Values

  @CreateAccount
  Scenario: Check if page displays correctly on mobile
    Given I open "{url}" on mobile device
    Then I see "Page displays correctly on mobile" is visible

  @RegisterAccount
  Scenario: Check if registration completes successfully
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Suburb/Location
    And I enter "<RANDOM:8>" as Password
    And I click on Create Account
    Then I see "Registration Successful" is visible

  @RegisterAccount
  Scenario: Check if user receives correct activation/verification email
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Suburb/Location
    And I enter "<RANDOM:8>" as Password
    And I click on Create Account
    Then I see "Activation Email Sent" is visible
    And I receive an email at "<RANDOM:8>@example.com"
    And I see "Verify Your Account" in the email subject
    And I see "Click here to verify your account" in the email body

