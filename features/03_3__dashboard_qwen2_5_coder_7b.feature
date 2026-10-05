Feature: Web Automation with Behave

  @name/business_information_display
  Scenario: Verify name/business information display
    Given I open "https://www.tradehub.com.au/dashboard"
    Then I see "User's Name" is displayed
    And I see "Business Information" is displayed

  @date/day_display
  Scenario: Verify date/day display
    Given I open "https://www.tradehub.com.au/dashboard"
    Then I see "Current Date" is displayed
    And I see "Current Day" is displayed

  @profile_information_card
  Scenario: Verify profile information/card display
    Given I open "https://www.tradehub.com.au/dashboard"
    Then I see "Profile Information Card" is displayed

  @profile_public_private_controls
  Scenario: Verify profile public/private controls
    Given I open "https://www.tradehub.com.au/dashboard"
    When I select "Public" as Profile Visibility
    And I select "Private" as Profile Visibility
    Then I see "Profile is now Public" is visible
    And I see "Profile is now Private" is visible

  @ABN_verification_status_area
  Scenario: Verify ABN verification status area
    Given I open "https://www.tradehub.com.au/dashboard"
    Then I see "ABN Verification Status" is displayed
    And I see "ABN is Verified" is visible
    Or I see "ABN is Not Verified" is visible

  @profile_views_statistic
  Scenario: Verify profile views statistic
    Given I open "https://www.tradehub.com.au/dashboard"
    Then I see "Profile Views Statistic" is displayed

  @openJobsInYourArea
  Scenario: Verify open jobs in your area
    Given I open "https://www.tradehub.com.au/dashboard"
    Then I see "Open Jobs" is visible
    And I see "Jobs in your area" is visible
    And I see "Job details" is visible

  @unreadMessageCount
  Scenario: Verify unread message count
    Given I open "https://www.tradehub.com.au/dashboard"
    Then I see "Unread Messages" is visible
    And I see "Message count" is visible

  @recentListings
  Scenario: Verify recent listings
    Given I open "https://www.tradehub.com.au/dashboard"
    Then I see "Recent Listings" is visible
    And I see "Listing details" is visible

  @clickEachDashboardLink
  Scenario: Click each dashboard link
    Given I open "https://www.tradehub.com.au/dashboard"
    When I click on "Open Jobs"
    Then I see "Open Jobs" page is visible
    And I click on "Unread Messages"
    Then I see "Unread Messages" page is visible
    And I click on "Recent Listings"
    Then I see "Recent Listings" page is visible

  @missingInformation
  Scenario: Verify missing information
    Given I open "https://www.tradehub.com.au/dashboard"
    Then I do not see "Missing Information" is visible

  @incorrectCounts
  Scenario: Verify incorrect counts
    Given I open "https://www.tradehub.com.au/dashboard"
    Then I do not see "Incorrect Counts" is visible

  @Dashboard
  Scenario: Verify overlapping text
    Given I open the dashboard
    Then I see no overlapping text

  @Dashboard
  Scenario: Verify empty areas
    Given I open the dashboard
    Then I see no empty areas

  @Dashboard
  Scenario: Verify buttons that cannot be clicked
    Given I open the dashboard
    Then I see no buttons that cannot be clicked

  @Dashboard
  Scenario: Verify incorrect mobile layout
    Given I open the dashboard on a mobile device
    Then I see the correct mobile layout

  @Dashboard
  Scenario: Verify information that does not update after actions are completed
    Given I open the dashboard
    When I perform an action
    Then I see the information updates correctly

  @Dashboard
  Scenario: Verify ABN verification status area with invalid ABN
    Given I open the dashboard
    When I enter an invalid ABN in the ABN verification area
    Then I see an error message in the ABN verification status area

  @invalid_input
  Scenario: Verify profile public/private controls with invalid input
    Given I open "https://www.tradehub.com.au/dashboard"
    When I enter "<RANDOM:8>" as Public/Private Setting
    Then I see "Invalid input" error message is visible

  @concurrent_operations
  Scenario: Verify profile views statistic with concurrent operations
    Given I open "https://www.tradehub.com.au/dashboard"
    When I simulate multiple users viewing the profile concurrently
    Then I see the profile views statistic updates correctly

  @zero_jobs
  Scenario: Verify open jobs in your area with zero jobs
    Given I open "https://www.tradehub.com.au/dashboard"
    When I select "Open Jobs" tab
    Then I see "No open jobs available" message is visible

  @maximum_listings
  Scenario: Verify recent listings with maximum number of listings
    Given I open "https://www.tradehub.com.au/dashboard"
    When I select "Recent Listings" tab
    Then I see the maximum number of listings displayed correctly

  @empty_string_input
  Scenario: Verify recent listings with empty string input
    Given I open "https://www.tradehub.com.au/dashboard"
    When I enter "" as Search Query
    Then I see "No results found" message is visible

  @character_limit
  Scenario: Verify recent listings with character limit
    Given I open "https://www.tradehub.com.au/dashboard"
    When I enter "<RANDOM:100>" as Search Query
    Then I see "Character limit exceeded" error message is visible

