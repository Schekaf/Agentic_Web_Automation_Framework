Feature: Web Automation with Behave

  @NavigateToSubcontractingAvailability
  Scenario: Navigate to List Subcontracting Dates / Availability
    Given I open "https://www.tradehub.com.au"
    When I navigate to the "Subcontracting Availability" page
    Then I see "Subcontracting Availability" page is visible

  @SelectFutureDates
  Scenario: Select Future Dates
    Given I open "https://www.tradehub.com.au"
    When I navigate to the "Subcontracting Availability" page
    And I select "Future Dates"
    Then I see "Future Dates" selected

  @AddDescription
  Scenario: Add Description
    Given I open "https://www.tradehub.com.au"
    When I navigate to the "Subcontracting Availability" page
    And I enter "<description>" as Description
    Then I see "Description" field is populated with "<description>"

  @EnterNumberOfWorkers
  Scenario: Enter Number/Type of Workers
    Given I open "https://www.tradehub.com.au"
    When I navigate to the "Subcontracting Availability" page
    And I enter "{number_of_workers}" as Number of Workers
    Then I see "Number of Workers" field is populated with "{number_of_workers}"

  @EnterRate
  Scenario: Enter Rate
    Given I open "https://www.tradehub.com.au"
    When I navigate to the "Subcontracting Availability" page
    And I enter "{rate}" as Rate
    Then I see "Rate" field is populated with "{rate}"

  @SaveAvailability
  Scenario: Save Availability
    Given I open "https://www.tradehub.com.au"
    When I navigate to the "Subcontracting Availability" page
    And I enter "{number_of_workers}" as Number of Workers
    And I enter "{rate}" as Rate
    And I click on the "Save" button
    Then I see the "Availability saved successfully" message

  @ListSubcontractingAvailability
  Scenario: Confirm Dates on Account
    Given I open "https://www.tradehub.com.au"
    When I navigate to the "Account" page
    And I select the "Subcontracting Availability" tab
    Then I see the saved availability dates displayed on the "Account" page

  @ListSubcontractingAvailability
  Scenario: Refresh Page
    Given I open "https://www.tradehub.com.au"
    When I navigate to the "Account" page
    And I select the "Subcontracting Availability" tab
    And I refresh the page
    Then I see the saved availability dates remain displayed on the "Account" page

  @ListSubcontractingAvailability
  Scenario: Edit Dates
    Given I open "https://www.tradehub.com.au"
    When I navigate to the "Account" page
    And I select the "Subcontracting Availability" tab
    And I click on the edit icon next to the saved availability date
    And I enter "{new_availability_dates}" as Availability Dates
    And I click on the "Save Changes" button
    Then I see the updated availability dates displayed on the "Account" page

  @ListSubcontractingAvailability
  Scenario: Edit Description
    Given I open "https://www.tradehub.com.au"
    When I navigate to the "Account" page
    And I select the "Subcontracting Availability" tab
    And I click on the edit icon next to the saved availability date
    And I enter "{new_availability_description}" as Availability Description
    And I click on the "Save Changes" button
    Then I see the updated availability description displayed on the "Account" page

  @ListSubcontractingAvailability
  Scenario: Remove Available Date
    Given I open "https://www.tradehub.com.au"
    When I navigate to the "Account" page
    And I select the "Subcontracting Availability" tab
    And I click on the "Delete" icon next to the saved availability date
    And I click on the "Confirm Deletion" button
    Then I do not see the deleted availability date displayed on the "Account" page

  @ListSubcontractingAvailability
  Scenario: Add Another Available Date
    Given I open "https://www.tradehub.com.au"
    When I navigate to the "Account" page
    And I select the "Subcontracting Availability" tab
    And I click on the "Add New Date" button
    And I enter "{new_availability_dates}" as Availability Dates
    And I click on the "Save Changes" button
    Then I see the new availability date displayed on the "Account" page

  @DeleteAvailabilityListing
  Scenario: Delete/Cancel Availability Listing
    Given I open "https://www.tradehub.com.au"
    When I select a saved availability listing from the directory
    And I click on the "Delete/Cancel" button
    Then I do not see the availability listing displayed in the directory

  @SearchDirectoryUnauthorized
  Scenario: Search Directory Using Another Account
    Given I open "https://www.tradehub.com.au"
    When I attempt to search the directory with an unauthorized account
    Then I see an error message indicating that the action is unauthorized

  @ShowUpcomingAvailableDates
  Scenario: Enable Show Only Profiles with Upcoming Available Dates
    Given I open "https://www.tradehub.com.au"
    When I select the filter option to show only profiles with upcoming available dates in the directory
    Then I see only profiles with upcoming available dates displayed in the directory

  @TestBusinessAppears
  Scenario: Confirm Test Business Appears
    Given I open "https://www.tradehub.com.au"
    When I enable the filter to show only profiles with upcoming available dates in the directory
    Then I see the test business displayed in the directory

  @AvailableDatesCorrect
  Scenario: Confirm Available Dates Are Correct
    Given I open "https://www.tradehub.com.au"
    When I select a business with available dates in the directory
    Then I see the correct available dates displayed in the directory

  @EmptyDescriptionInput
  Scenario: Empty Description Input
    Given I open "https://www.tradehub.com.au"
    When I attempt to enter an empty description in the Description field
    Then I see an error message indicating that the input is invalid in the Description field

  @ListSubcontractingAvailability
  Scenario: Character Limit for Description
    Given I open "{url}"
    When I enter "{text}" as Description
    And I click on the "Submit" button
    Then I see "Description exceeds character limit" is visible

  @ListSubcontractingAvailability
  Scenario: Rate Limit for Availability Entries
    Given I open "{url}"
    When I enter "{text}" as Availability
    And I click on the "Submit" button
    Then I see "Rate limit exceeded" is visible