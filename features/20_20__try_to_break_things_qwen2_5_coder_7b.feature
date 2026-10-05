Feature: Web Automation with Behave

  @TryToBreakThings_S01
  Scenario: Submit an empty form
    Given I open "https://www.tradehub.com.au/register"
    When I click on "Submit" button
    Then I see "Error: All fields are required" is visible

  @TryToBreakThings_S02
  Scenario: Enter very long descriptions
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:1000>" as Description
    Then I see "Error: Description is too long" is visible

  @TryToBreakThings_S03
  Scenario: Enter unusual characters
    Given I open "https://www.tradehub.com.au/register"
    When I enter "@#$$%^&*()" as Name
    Then I see "Error: Invalid characters" is visible

  @TryToBreakThings_S04
  Scenario: Double-click Submit
    Given I open "https://www.tradehub.com.au/register"
    When I double-click on "Submit" button
    Then I see "Form submitted successfully" is visible

  @TryToBreakThings_S05
  Scenario: Refresh during a form
    Given I open "https://www.tradehub.com.au/register"
    When I enter "Furkan" as Name
    When I press on "F5" Key
    Then I see "Form is refreshed" is visible

  @TryToBreakThings_S06
  Scenario: Click Back after submitting
    Given I open "https://www.tradehub.com.au/register"
    When I enter "Furkan" as Name
    When I click on "Submit" button
    When I click the Go Back Button
    Then I see "Registration form is displayed" is visible

  @TryToBreakThings @Negative @BoundaryEdgeCase
  Scenario: Upload a large attachment
    Given I open "{url}"
    When I click on "Register"
    And I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>" as Suburb/Location
    And I enter "<RANDOM:8>" as Password
    And I click on "Upload"
    And I select a file larger than the allowed limit
    Then I see "File size exceeds limit" is visible

  @TryToBreakThings @Negative @BoundaryEdgeCase
  Scenario: Upload an unsupported file type
    Given I open "{url}"
    When I click on "Register"
    And I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>" as Suburb/Location
    And I enter "<RANDOM:8>" as Password
    And I click on "Upload"
    And I select a file with an unsupported file type
    Then I see "Unsupported file type" is visible

  @TryToBreakThings @Negative @BoundaryEdgeCase
  Scenario: Select a date in the past
    Given I open "{url}"
    When I click on "Register"
    And I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>" as Suburb/Location
    And I enter "<RANDOM:8>" as Password
    And I click on "Select Date"
    And I select a date in the past
    Then I see "Invalid date" is visible

  @TryToBreakThings @Negative
  Scenario: Enter an incorrect ABN
    Given I open "{url}"
    When I click on "Register"
    And I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>" as Suburb/Location
    And I enter "<RANDOM:8>" as Password
    And I click on "Add ABN"
    And I enter an incorrect ABN
    Then I see "Invalid ABN" is visible

