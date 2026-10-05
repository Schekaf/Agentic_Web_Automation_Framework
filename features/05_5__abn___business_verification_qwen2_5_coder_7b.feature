Feature: Web Automation with Behave

  @ABN
  Scenario: Browse jobs without an ABN
    Given I open "https://www.tradehub.com.au"
    When I click on "Jobs"
    Then I see "Job listings" is visible

  @ABN
  Scenario: Browse tenders without an ABN
    Given I open "https://www.tradehub.com.au"
    When I click on "Tenders"
    Then I see "Tender listings" is visible

  @ABN
  Scenario: Browse the Directory without an ABN
    Given I open "https://www.tradehub.com.au"
    When I click on "Directory"
    Then I see "Business profiles" is visible

  @ABN
  Scenario: Post a job without an ABN and verify system requests ABN
    Given I open "https://www.tradehub.com.au"
    When I click on "Post Job"
    Then I see "ABN is required" is visible

  @ABN
  Scenario: Apply/quote for a job where applicable without an ABN and verify system requests ABN
    Given I open "https://www.tradehub.com.au"
    When I click on "Apply for Job"
    Then I see "ABN is required" is visible

  @ABN
  Scenario: Post a tender without an ABN and verify system requests ABN
    Given I open "https://www.tradehub.com.au"
    When I click on "Post Tender"
    Then I see "ABN is required" is visible

  @ABN
  Scenario: Quote on a tender without an ABN and verify system requests ABN
    Given I open "https://www.tradehub.com.au/register"
    When I click on "Register"
    And I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Submit"
    Then I see "Please provide an ABN" is visible

  @ABN
  Scenario: List subcontracting availability without an ABN and verify system requests ABN
    Given I open "https://www.tradehub.com.au/register"
    When I click on "Register"
    And I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Submit"
    Then I see "Please provide an ABN" is visible

  @ABN
  Scenario: Enter an ABN
    Given I open "https://www.tradehub.com.au/register"
    When I click on "Register"
    And I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Submit"
    And I enter "<RANDOM:8>" as ABN
    And I click on "Save"

  @ABN
  Scenario: Save it
    Given I open "https://www.tradehub.com.au/register"
    When I click on "Register"
    And I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Submit"
    And I enter "<RANDOM:8>" as ABN
    And I click on "Save"
    Then I see "ABN saved successfully" is visible

  @ABN
  Scenario: Confirm the ABN is attached to the account
    Given I open "https://www.tradehub.com.au/register"
    When I click on "Register"
    And I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Submit"
    And I enter "<RANDOM:8>" as ABN
    And I click on "Save"
    Then I see "ABN is attached to your account" is visible

  @ABN
  Scenario: Repeat an action that was previously restricted
    Given I open "https://www.tradehub.com.au/register"
    When I click on "Register"
    And I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Submit"
    And I enter "<RANDOM:8>" as ABN
    And I click on "Save"
    And I click on "Post Job"
    And I enter "<RANDOM:8>" as Job Title
    And I enter "<RANDOM:8>" as Job Description
    And I click on "Post"
    Then I see "Job posted successfully" is visible

  @ABN
  Scenario: Confirm you can now continue
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    Then I see "Registration Successful" is visible
    And I see "Please verify your email" is visible
    And I click on "Continue"
    Then I see "You can now continue" is visible

