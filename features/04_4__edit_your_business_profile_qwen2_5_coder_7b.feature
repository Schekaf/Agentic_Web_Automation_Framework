Feature: Web Automation with Behave

  @ViewProfile
  Scenario: View your profile
    Given I open "https://www.tradehub.com.au"
    When I click on "Edit Profile"
    Then I see "Edit Profile" form is visible

  @EditProfile
  Scenario: Click Edit Profile
    Given I open "https://www.tradehub.com.au"
    When I click on "Edit Profile"
    Then I see "Edit Profile" form is visible

  @EditDescription
  Scenario: Add or edit business description
    Given I open "https://www.tradehub.com.au"
    When I click on "Edit Profile"
    And I enter "<RANDOM:8>" as Business Description
    And I click on "Save"
    Then I see "Business Description" is updated

  @AddPhoneNumber
  Scenario: Add business phone number
    Given I open "https://www.tradehub.com.au"
    When I click on "Edit Profile"
    And I enter "+1234567890" as Phone Number
    And I click on "Save"
    Then I see "Phone Number" is updated

  @AddWebsite
  Scenario: Add website if available
    Given I open "https://www.tradehub.com.au"
    When I click on "Edit Profile"
    And I enter "https://www.example.com" as Website
    And I click on "Save"
    Then I see "Website" is updated

  @AddServiceLocation
  Scenario: Add service/location information
    Given I open "https://www.tradehub.com.au"
    When I click on "Edit Profile"
    And I enter "123 Main St" as Address
    And I enter "Anytown" as Suburb
    And I enter "12345" as Postcode
    And I click on "Save"
    Then I see "Service/Location Information" is updated

  @AddRate
  Scenario: Add hourly or day rate if available
    Given I open the TradeHub website
    When I navigate to the Business Profile page
    And I enter my hourly rate as <RANDOM:8> as Hourly Rate
    And I enter my day rate as <RANDOM:8> as Day Rate
    And I click on Save button
    Then I see a success message indicating the rates have been saved

  @UploadImage
  Scenario: Upload/change profile image or logo
    Given I open the TradeHub website
    When I navigate to the Business Profile page
    And I click on the Profile Image/Logo upload button
    And I select a new image file
    And I click on Save button
    Then I see a success message indicating the image has been uploaded

  @EditOtherInfo
  Scenario: Edit any other available business information
    Given I open the TradeHub website
    When I navigate to the Business Profile page
    And I enter new business information in the relevant fields
    And I click on Save button
    Then I see a success message indicating the information has been updated

  @SaveProfile
  Scenario: Save the profile
    Given I open the TradeHub website
    When I navigate to the Business Profile page
    And I make changes to the profile
    And I click on Save button
    Then I see a success message indicating the profile has been saved

  @RefreshPage
  Scenario: Refresh the page
    Given I open the TradeHub website
    When I navigate to the Business Profile page
    And I refresh the page
    Then I see the Business Profile page is refreshed

  @ConfirmSaved
  Scenario: Confirm all changes remain saved
    Given I open the TradeHub website
    When I navigate to the Business Profile page
    And I make changes to the profile
    And I click on Save button
    And I refresh the page
    Then I see the changes are still present in the profile

  @ViewPublicProfile
  Scenario: View the public version of the profile
    Given I open the public profile page
    Then I see the public profile is visible

  @PublicProfileCorrect
  Scenario: Check that the public profile displays the correct information
    Given I open the public profile page
    Then I see the correct Name is displayed
    And I see the correct Business Name is displayed
    And I see the correct Email is displayed
    And I see the correct Phone is displayed
    And I see the correct Primary Trade is displayed
    And I see the correct Suburb/Location is displayed

  @ChangeVisibility
  Scenario: Change the profile between Public and Private
    Given I open the profile settings page
    When I select 'Private' as the profile visibility
    Then I see the profile visibility is changed to Private
    And I see the public profile is no longer visible
    When I select 'Public' as the profile visibility
    Then I see the profile visibility is changed to Public
    And I see the public profile is visible

  @ConfirmVisibility
  Scenario: Confirm the visibility setting behaves correctly
    Given I open the profile settings page
    When I select 'Private' as the profile visibility
    Then I see the profile visibility is changed to Private
    And I see the public profile is no longer visible
    When I select 'Public' as the profile visibility
    Then I see the profile visibility is changed to Public
    And I see the public profile is visible

  @EditAfterSetup
  Scenario: Edit the profile a second time to make sure information can be changed after initial setup
    Given I open the profile settings page
    When I enter 'New Name' as Name
    And I enter 'New Business Name' as Business Name
    And I enter 'New Email' as Email
    And I enter 'New Phone' as Phone
    And I select 'New Primary Trade' as Primary Trade
    And I enter 'New Suburb/Location' as Suburb/Location
    And I click on Save Changes
    Then I see the profile information is updated

  @UnauthorizedAccess
  Scenario: Unauthorized access to edit profile
    Given I open the public profile page
    When I click on Edit Profile
    Then I see an error message indicating unauthorized access

  @InvalidPayload
  Scenario: Invalid payload inputs
    Given I open "https://www.tradehub.com.au"
    When I enter "<RANDOM:8>" as Name
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Phone
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Suburb/Location
    And I enter "<RANDOM:8>" as Password
    And I click on Create Account
    Then I see "Invalid payload" is visible

  @BoundaryEdgeCases
  Scenario: Boundary and edge cases for profile fields
    Given I open "https://www.tradehub.com.au"
    When I enter "" as Name
    And I enter "" as Business Name
    And I enter "" as Email
    And I enter "" as Phone
    And I select "Trade Business" as Primary Trade
    And I enter "" as Suburb/Location
    And I enter "" as Password
    And I click on Create Account
    Then I see "Empty fields" is visible
    Given I open "https://www.tradehub.com.au"
    When I enter "<RANDOM:1000>" as Name
    And I enter "<RANDOM:1000>" as Business Name
    And I enter "<RANDOM:1000>" as Email
    And I enter "<RANDOM:1000>" as Phone
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:1000>" as Suburb/Location
    And I enter "<RANDOM:1000>" as Password
    And I click on Create Account
    Then I see "Maximum character limit" is visible
    Given I open "https://www.tradehub.com.au"
    When I enter "1234567890" as Phone
    And I click on Create Account
    Then I see "Invalid phone number" is visible