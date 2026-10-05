Feature: Web Automation with Behave

  @public_homepage
  Scenario: Visit homepage while logged out
    Given I open "https://www.tradehub.com.au"
    Then I see "Welcome to TradeHub" is visible

  @public_tenders_page
  Scenario: Open public Tenders page while logged out
    Given I open "https://www.tradehub.com.au/tenders"
    Then I see "Public Tenders" is visible

  @individual_public_tender
  Scenario: Open individual public tender while logged out
    Given I open "https://www.tradehub.com.au/tenders/12345"
    Then I see "Individual Public Tender" is visible

  @blurred_restricted_info
  Scenario: Check blurred/restricted information while logged out
    Given I open "https://www.tradehub.com.au/tenders/12345"
    Then I see "Confidential Information" is blurred

  @restricted_actions
  Scenario: Try clicking actions requiring an account while logged out
    Given I open "https://www.tradehub.com.au/tenders/12345"
    When I click on "Apply for Tender"
    Then I see "Please log in to apply for this tender" is visible

  @login_prompt
  Scenario: Confirm TradeHub asks you to sign up/login when clicking restricted actions
    Given I open "https://www.tradehub.com.au/tenders/12345"
    When I click on "Apply for Tender"
    Then I see "Sign Up" or "Log In" prompt is visible

  @public_seo_tender_pages
  Scenario: Visit public SEO tender pages where available while logged out
    Given I open "https://www.tradehub.com.au/tenders"
    Then I see "Tender List" is visible
    And I see "Tender Details" is visible
    And I see "Apply for Tender" is visible
    And I see "View Tender" is visible
    And I see "Contact Supplier" is visible
    And I see "Supplier Profile" is visible
    And I see "Tender Status" is visible
    And I see "Tender Budget" is visible

  @website_navigation
  Scenario: Test navigation throughout the public website while logged out
    Given I open "https://www.tradehub.com.au"
    When I click on "Home"
    Then I see "Home Page" is visible
    And I click on "About Us"
    Then I see "About Us Page" is visible
    And I click on "Contact Us"
    Then I see "Contact Us Page" is visible
    And I click on "FAQs"
    Then I see "FAQs Page" is visible
    And I click on "Tenders"
    Then I see "Tenders Page" is visible

  @private_info_visibility
  Scenario: Check for any private information that is accidentally visible while logged out
    Given I open "https://www.tradehub.com.au"
    Then I do not see "Private Information" is visible
    And I do not see "Personal Details" is visible
    And I do not see "Account Details" is visible
    And I do not see "Profile Information" is visible
    And I do not see "Job Details" is visible
    And I do not see "Tender Details" is visible
    And I do not see "Quote Details" is visible
    And I do not see "Availability Details" is visible

