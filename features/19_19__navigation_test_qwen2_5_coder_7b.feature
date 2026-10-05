Feature: Web Automation with Behave

  @Navigation
  Scenario: Navigate to Dashboard
    Given I open "https://www.tradehub.com.au"
    When I click on "Dashboard" link
    Then I see "Dashboard" page is visible

  @Navigation
  Scenario: Navigate to Jobs
    Given I open "https://www.tradehub.com.au"
    When I click on "Jobs" link
    Then I see "Jobs" page is visible

  @Navigation
  Scenario: Navigate to Find Jobs
    Given I open "https://www.tradehub.com.au"
    When I click on "Find Jobs" link
    Then I see "Find Jobs" page is visible

  @Navigation
  Scenario: Navigate to Post a Job
    Given I open "https://www.tradehub.com.au"
    When I click on "Post a Job" link
    Then I see "Post a Job" page is visible

  @Navigation
  Scenario: Navigate to Tenders
    Given I open "https://www.tradehub.com.au"
    When I click on "Tenders" link
    Then I see "Tenders" page is visible

  @Navigation
  Scenario: Navigate to Post Project Tender
    Given I open "https://www.tradehub.com.au"
    When I click on "Post Project Tender" link
    Then I see "Post Project Tender" page is visible

  @Navigation
  Scenario: Navigate to Directory
    Given I open "https://www.tradehub.com.au"
    When I click on "Directory" link
    Then I see "Directory" page is visible

  @Navigation
  Scenario: Navigate to Profile
    Given I open "https://www.tradehub.com.au"
    When I click on "Profile" link
    Then I see "Profile" page is visible

  @Navigation
  Scenario: Navigate to Messages
    Given I open "https://www.tradehub.com.au"
    When I click on "Messages" link
    Then I see "Messages" page is visible

  @Navigation
  Scenario: Navigate to Notifications
    Given I open "https://www.tradehub.com.au"
    When I click on "Notifications" link
    Then I see "Notifications" page is visible

  @Navigation
  Scenario: Navigate to Availability
    Given I open "https://www.tradehub.com.au"
    When I click on "Availability" link
    Then I see "Availability" page is visible

  @Navigation
  Scenario: Navigate to Upgrade/Premium
    Given I open "https://www.tradehub.com.au"
    When I click on "Upgrade/Premium" link
    Then I see "Upgrade/Premium" page is visible

  @Navigation
  Scenario: Navigate to Logout
    Given I open "https://www.tradehub.com.au"
    When I click on "Logout"
    Then I see "Login" is visible

  @Security
  Scenario: Unauthorized Access to Dashboard
    Given I open "https://www.tradehub.com.au/dashboard"
    Then I see "Unauthorized Access" is visible

  @Security
  Scenario: Invalid Payload for Dashboard
    Given I open "https://www.tradehub.com.au/dashboard"
    When I enter "<RANDOM:8>" as Payload
    Then I see "Invalid Payload" is visible

  @Security
  Scenario: Empty String for Dashboard
    Given I open "https://www.tradehub.com.au/dashboard"
    When I enter "" as Payload
    Then I see "Empty Payload" is visible

  @Security
  Scenario: Character Limit for Dashboard
    Given I open "https://www.tradehub.com.au/dashboard"
    When I enter "<RANDOM:100>" as Payload
    Then I see "Character Limit Exceeded" is visible

  @Security
  Scenario: Rate Limit for Dashboard
    Given I open "https://www.tradehub.com.au/dashboard"
    When I click on "Dashboard" 100 times in 1 minute
    Then I see "Rate Limit Exceeded" is visible

  @Security
  Scenario: State Transition Conflict for Dashboard
    Given I open "https://www.tradehub.com.au/dashboard"
    When I click on "Dashboard" link
    And I click on "Settings" link
    And I click on "Logout" link
    Then I see "Login" page is visible

  @Security
  Scenario: Concurrent Operations for Dashboard
    Given I open "https://www.tradehub.com.au/dashboard"
    When I click on "Dashboard" link
    And I click on "Settings" link
    And I click on "Logout" link
    And I click on "Dashboard" link
    Then I see "Dashboard" page is visible

