Feature: Web Automation with Behave

  @FreeAccount @RadiusRestriction
  Scenario: Verify Free account 15 km radius restriction
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on Create Account
    Then I see "File size exceeds limit" is visible

  @FreeAccount @TenderBrowsing
  Scenario: Verify Free account tender browsing
    Given I open "https://www.tradehub.com.au/tenders"
    When I enter "<RANDOM:8>" as Search Query
    Then I see "No results found" is visible

  @FreeAccount @TenderPosting
  Scenario: Verify Free account free tender posting allowance
    Given I open "https://www.tradehub.com.au/post-tender"
    When I enter "<RANDOM:8>" as Tender Title
    And I enter "<RANDOM:8>" as Description
    And I enter "<RANDOM:8>" as Budget
    And I click on Post Tender
    Then I see "Tender posted successfully" is visible

  @FreeAccount @TenderQuoting
  Scenario: Verify Free account tender quote allowance
    Given I open "https://www.tradehub.com.au/tenders"
    When I enter "<RANDOM:8>" as Search Query
    Then I see "No results found" is visible

  @FreeAccount @QuoteLimits
  Scenario: Verify Free account quote limits
    Given I open "https://www.tradehub.com.au/tenders"
    When I enter "<RANDOM:8>" as Search Query
    Then I see "No results found" is visible

  @FreeAccount @Notifications
  Scenario: Verify Free account in-app notifications
    Given I open "https://www.tradehub.com.au/dashboard"
    When I click on Notifications
    Then I see "No notifications" is visible

  @FreeAccount @JobsAccess
  Scenario: Verify Free account jobs access
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    Then I see "Success Message" is "Visible"
    And I click on "Login"
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    And I click on "Jobs"
    Then I see "Jobs" is "Visible"
    And I see "15 km radius" is "Visible"

  @FreeAccount @DirectoryAccess
  Scenario: Verify Free account directory access
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    Then I see "Success Message" is "Visible"
    And I click on "Login"
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    And I click on "Directory"
    Then I see "Directory" is "Visible"
    And I see "15 km radius" is "Visible"

  @PremiumAccount @RadiusRestriction
  Scenario: Verify Premium account unlimited radius
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    Then I see "Success Message" is "Visible"
    And I click on "Login"
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    And I click on "Upgrade to Premium"
    Then I see "Premium Upgrade" is "Visible"
    And I click on "Confirm Upgrade"
    And I click on "Jobs"
    Then I see "Jobs" is "Visible"
    And I see "Unlimited Radius" is "Visible"

  @PremiumAccount @JobsAccess
  Scenario: Verify Premium account unlimited jobs
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    Then I see "Success Message" is "Visible"
    And I click on "Login"
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    And I click on "Upgrade to Premium"
    Then I see "Premium Upgrade" is "Visible"
    And I click on "Confirm Upgrade"
    And I click on "Jobs"
    Then I see "Jobs" is "Visible"
    And I see "Unlimited Jobs" is "Visible"

  @PremiumAccount @TenderAccess
  Scenario: Verify Premium account unlimited tender access
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    Then I see "Success Message" is "Visible"
    And I click on "Login"
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    And I click on "Upgrade to Premium"
    Then I see "Premium Upgrade" is "Visible"
    And I click on "Confirm Upgrade"
    And I click on "Tenders"
    Then I see "Tenders" is "Visible"
    And I see "Unlimited Tender Access" is "Visible"

  @PremiumAccount @TenderQuoting
  Scenario: Verify Premium account unlimited tender quotes
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    Then I see "Success Message" is "Visible"
    And I click on "Login"
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    And I click on "Upgrade to Premium"
    Then I see "Premium Upgrade" is "Visible"
    And I click on "Confirm Upgrade"
    And I click on "Tenders"
    Then I see "Tenders" is "Visible"
    And I see "Unlimited Tender Quotes" is "Visible"

  @PremiumAccount @TenderPosting
  Scenario: Verify Premium account unlimited tender posting
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    And I click on "Verify Account"
    And I enter a valid ABN
    And I click on "Submit"
    Then I see "Premium Account" is "Active"
    And I see "Unlimited Tender Posting" is "Enabled"

  @PremiumAccount @AvailabilityBroadcasts
  Scenario: Verify Premium account availability broadcasts
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    And I click on "Verify Account"
    And I enter a valid ABN
    And I click on "Submit"
    Then I see "Premium Account" is "Active"
    And I see "Availability Broadcasts" is "Enabled"

  @PremiumAccount @Alerts
  Scenario: Verify Premium account SMS/email alerts
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    And I click on "Verify Account"
    And I enter a valid ABN
    And I click on "Submit"
    Then I see "Premium Account" is "Active"
    And I see "SMS/Email Alerts" is "Enabled"

  @PremiumAccount @BadgeFunctionality
  Scenario: Verify Premium account premium/verified badge functionality
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    And I click on "Verify Account"
    And I enter a valid ABN
    And I click on "Submit"
    Then I see "Premium Account" is "Active"
    And I see "Premium/Verified Badge" is "Displayed"

  @PremiumAccount @MarketRateInformation
  Scenario: Verify Premium account market rate information
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    And I click on "Verify Account"
    And I enter a valid ABN
    And I click on "Submit"
    Then I see "Premium Account" is "Active"
    And I see "Market Rate Information" is "Available"

  @PremiumAccount @RestrictionEnforcement
  Scenario: Verify Premium users are not accidentally shown Free restrictions
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    And I click on "Verify Account"
    And I enter a valid ABN
    And I click on "Submit"
    Then I see "Premium Account" is "Active"
    And I do not see "Free Account Restrictions" is "Visible"

