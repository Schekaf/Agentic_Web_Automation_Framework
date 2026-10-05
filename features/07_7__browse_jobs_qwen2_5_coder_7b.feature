Feature: Web Automation with Behave

  @functional
  Scenario: Open Find Jobs / Jobs
    Given I open "https://www.tradehub.com.au/jobs"
    Then I see "Jobs" page is visible

  @functional
  Scenario: Browse Available Jobs
    Given I open "https://www.tradehub.com.au/jobs"
    When I scroll down the page
    Then I see multiple job listings

  @functional
  Scenario: Search for Jobs
    Given I open "https://www.tradehub.com.au/jobs"
    When I enter "Plumbing" in search bar
    Then I see job listings related to Plumbing

  @functional
  Scenario: Filter by Trade
    Given I open "https://www.tradehub.com.au/jobs"
    When I select "Plumbing" as Trade
    Then I see job listings related to Plumbing

  @functional
  Scenario: Filter by Location/Distance
    Given I open "https://www.tradehub.com.au/jobs"
    When I select "10km" as Distance
    Then I see job listings within 10km

  @functional
  Scenario: Open Several Job Listings
    Given I open "https://www.tradehub.com.au/jobs"
    When I click on the first job listing
    And I click on the second job listing
    Then I see details of two job listings

  @Functional
  Scenario: Return to Job Search Results
    Given I open "https://www.tradehub.com.au/jobs"
    When I click on Job Listing 1
    And I click on Apply/View Details
    Then I see Job Search Results page is visible

  @Functional
  Scenario: Check Search/Filter Settings
    Given I open "https://www.tradehub.com.au/jobs"
    When I click on Job Listing 1
    And I click on Apply/View Details
    Then I see Search/Filter settings are intact

  @Functional
  Scenario: Test Experience on Mobile
    Given I open "https://www.tradehub.com.au/jobs" on a mobile device
    When I click on Job Listing 1
    And I click on Apply/View Details
    Then I see Job Search Results page is visible on mobile

  @Functional
  Scenario: Open Job to Test Applying
    Given I open "https://www.tradehub.com.au/jobs"
    When I click on Job Listing 1
    And I click on Apply/View Details
    Then I see Apply/Respond to Job page is visible

  @Functional
  Scenario: Apply/Respond to Job
    Given I open "https://www.tradehub.com.au/jobs"
    When I click on Job Listing 1
    And I click on Apply/View Details
    And I enter "<RANDOM:8>" as Name
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Phone
    And I select "Trade Business" as Primary Trade
    And I click on Submit Application
    Then I see Application Confirmation page is visible

  @Functional
  Scenario: Go Backwards Without Becoming Stuck
    Given I open "https://www.tradehub.com.au/jobs"
    When I click on Job Listing 1
    And I click on Apply/View Details
    And I click on Go Back Button
    Then I see Job Search Results page is visible

  @functional
  Scenario: Return to Jobs List
    Given I open the jobs list page
    When I apply to a job
    Then I see the jobs list page is displayed

  @functional
  Scenario: Verify Application Submission
    Given I open the job application page
    When I fill out the application form with valid data
    And I submit the application
    Then I see a confirmation message indicating successful submission

  @functional
  Scenario: Unauthorized Access
    Given I am not logged in
    When I try to access the jobs list page
    Then I see an unauthorized access message

  @functional
  Scenario: Invalid Payload Inputs
    Given I open the job application page
    When I fill out the application form with invalid data
    And I submit the application
    Then I see an error message indicating invalid inputs

  @functional
  Scenario: Empty/Null String Inputs
    Given I open the job application page
    When I fill out the application form with empty or null string inputs
    And I submit the application
    Then I see an error message indicating empty or null inputs

  @functional
  Scenario: Character Limits
    Given I open the job application page
    When I enter a job title exceeding the character limit
    And I submit the application
    Then I see an error message indicating character limit exceeded

