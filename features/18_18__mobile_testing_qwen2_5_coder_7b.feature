Feature: Web Automation with Behave

  @AccountRegistration
  Scenario: Register Account on Mobile
    Given I open the mobile app
    When I click on Register Account
    And I enter "<RANDOM:8>" as Name
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Suburb/Location
    And I enter "<RANDOM:8>" as Password
    And I click on Register
    Then I see "Registration Successful" message

  @Login
  Scenario: Login Account on Mobile
    Given I open the mobile app
    When I click on Login Account
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Password
    And I click on Login
    Then I see "Login Successful" message

  @Logout
  Scenario: Logout Account on Mobile
    Given I open the mobile app
    When I click on Profile Icon
    And I click on Logout
    Then I see "Logged Out" message

  @Dashboard
  Scenario: Dashboard on Mobile
    Given I open the mobile app
    When I click on Dashboard Icon
    Then I see "Dashboard" page

  @EditProfile
  Scenario: Edit Profile on Mobile
    Given I open the mobile app
    When I click on Profile Icon
    And I click on Edit Profile
    And I enter "<RANDOM:8>" as Name
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Phone
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Suburb/Location
    And I enter "<RANDOM:8>" as Password
    And I click on Save
    Then I see "Profile Updated" message

  @Directory
  Scenario: Directory on Mobile
    Given I open the mobile app
    When I click on Directory Icon
    Then I see "Directory" page

  @FindJobs
  Scenario: Find Jobs on Mobile
    Given I open the TradeHub mobile app
    When I enter a search term in the Job Search field
    And I click on the Search button
    Then I see a list of job listings

  @OpenJob
  Scenario: Open Job on Mobile
    Given I open the TradeHub mobile app
    When I click on a job listing in the Job Search results
    Then I see the details of the selected job listing

  @ApplyForJob
  Scenario: Apply for Job on Mobile
    Given I open the TradeHub mobile app
    When I click on a job listing in the Job Search results
    And I click on the Apply button
    Then I see the application form for the job

  @ReturnFromApplyForJob
  Scenario: Return from Apply for Job on Mobile
    Given I open the TradeHub mobile app
    When I click on a job listing in the Job Search results
    And I click on the Apply button
    And I click on the Back button
    Then I see the Job Search results

  @PostJob
  Scenario: Post Job on Mobile
    Given I open the TradeHub mobile app
    When I click on the Post Job button
    And I enter job details in the Job Details form
    And I click on the Post button
    Then I see a confirmation message for the posted job

  @ViewTender
  Scenario: View Tender on Mobile
    Given I open the TradeHub mobile app
    When I click on a tender in the Tender Search results
    Then I see the details of the selected tender

  @submitTenderQuote
  Scenario: Submit Tender Quote on Mobile
    Given I open the TradeHub mobile app
    When I navigate to the Tenders section
    And I select a tender
    And I enter my quote details
    And I submit the quote
    Then I see the quote submission confirmation

  @messages
  Scenario: Messages on Mobile
    Given I open the TradeHub mobile app
    When I navigate to the Messages section
    Then I see the list of messages

  @notifications
  Scenario: Notifications on Mobile
    Given I open the TradeHub mobile app
    When I navigate to the Notifications section
    Then I see the list of notifications

  @listAvailability
  Scenario: List Availability on Mobile
    Given I open the TradeHub mobile app
    When I navigate to the Availability section
    And I select a date range
    And I save the availability
    Then I see the availability listed

  @textOverlapping
  Scenario: Check for Text Overlapping on Mobile
    Given I open the TradeHub mobile app
    When I navigate to the main screen
    Then I do not see any text overlapping

  @buttonsOutsideScreen
  Scenario: Check for Buttons Outside the Screen on Mobile
    Given I open the TradeHub mobile app
    When I navigate to the main screen
    Then I do not see any buttons outside the screen

  @ButtonsCoveredByMenus
  Scenario: Check for Buttons Covered by Menus on Mobile
    Given I open "https://www.tradehub.com.au/register"
    When I click on "Menu" button
    Then I see "Button" is not covered by "Menu"

  @TinyButtons
  Scenario: Check for Tiny Buttons on Mobile
    Given I open "https://www.tradehub.com.au/register"
    When I click on "Button"
    Then I see "Button" is not too small

  @MenusNotClosing
  Scenario: Check for Menus That Will Not Close on Mobile
    Given I open "https://www.tradehub.com.au/register"
    When I click on "Menu" button
    And I click on "Another Menu" button
    Then I see "Menu" closes properly

  @KeyboardCoveringInputFields
  Scenario: Check for Keyboard Covering Input Fields on Mobile
    Given I open "https://www.tradehub.com.au/register"
    When I click on "Input Field"
    Then I see "Input Field" is not covered by the keyboard

  @PagesNotScrolling
  Scenario: Check for Pages That Cannot Scroll on Mobile
    Given I open "https://www.tradehub.com.au/register"
    When I scroll down the page
    Then I see the page is scrollable

  @PopUpsNotClosing
  Scenario: Check for Pop-ups/Drawers That Cannot Be Closed on Mobile
    Given I open "https://www.tradehub.com.au/register"
    When I click on "Pop-up" button
    And I click on "Close" button
    Then I see "Pop-up" closes properly

  @BackButtonsNotWorking
  Scenario: Check for Back Buttons That Do Not Work on Mobile
    Given I open "https://www.tradehub.com.au/register"
    When I click on Back Button
    Then I should see the same page

  @FormsLosingInformation
  Scenario: Check for Forms Losing Information on Mobile
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I click on Next Step
    Then I should see the entered Name on the next page

  @LayoutDifferences
  Scenario: Check for Layouts That Look Significantly Different from Desktop on Mobile
    Given I open "https://www.tradehub.com.au/register" on a mobile device
    Then I should see a layout similar to desktop

  @NumericalThresholds
  Scenario: Check for Numerical Thresholds on Mobile
    Given I open "https://www.tradehub.com.au/register"
    When I enter "1000" as a numerical value
    Then I should see a success message

