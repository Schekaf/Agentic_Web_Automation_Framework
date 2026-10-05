Feature: Web Automation with Behave

  @Functional
  Scenario: Open Available Tenders with valid trade account
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on Create Account
    And I click on Verify Email Link
    And I open "https://www.tradehub.com.au/tenders"
    Then I see Available Tenders are listed

  @Functional
  Scenario: Open Available Tenders with invalid trade account
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on Create Account
    And I click on Verify Email Link
    And I open "https://www.tradehub.com.au/tenders"
    Then I do not see Available Tenders are listed

  @Functional
  Scenario: Find and open a specific tender
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on Create Account
    And I click on Verify Email Link
    And I open "https://www.tradehub.com.au/tenders"
    And I enter "<RANDOM:8>" as Search Term
    Then I see Specific Tender is listed
    And I click on Specific Tender
    Then I see Specific Tender Details are displayed

  @Functional
  Scenario: Open a non-existent tender
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on Create Account
    And I click on Verify Email Link
    And I open "https://www.tradehub.com.au/tenders"
    And I enter "<RANDOM:8>" as Search Term
    Then I do not see Specific Tender is listed

  @Functional
  Scenario: Confirm trade information visibility
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on Create Account
    And I click on Verify Email Link
    And I open "https://www.tradehub.com.au/tenders"
    And I click on Specific Tender
    Then I see Trade Information is visible

  @Functional
  Scenario: Submit a quote with valid price and message
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on Create Account
    And I click on Verify Email Link
    And I open "https://www.tradehub.com.au/tenders"
    And I click on Specific Tender
    And I enter "<RANDOM:8>" as Price
    And I enter "<RANDOM:8>" as Message
    And I click on Submit Quote
    Then I see Quote Submitted Successfully message

  @functional
  Scenario: Submit a quote with invalid price
    Given I open the tradehub website
    When I navigate to the tender page
    And I click on the quote button
    And I enter an invalid price in the price field
    And I click on the submit button
    Then I see an error message indicating invalid price

  @functional
  Scenario: Submit a quote with empty message
    Given I open the tradehub website
    When I navigate to the tender page
    And I click on the quote button
    And I leave the message field empty
    And I click on the submit button
    Then I see an error message indicating empty message

  @functional
  Scenario: Upload supporting information
    Given I open the tradehub website
    When I navigate to the tender page
    And I click on the quote button
    And I upload a supporting document
    And I click on the submit button
    Then I see a confirmation message indicating successful upload

  @functional
  Scenario: Submit a quote with no supporting information
    Given I open the tradehub website
    When I navigate to the tender page
    And I click on the quote button
    And I do not upload any supporting document
    And I click on the submit button
    Then I see an error message indicating no supporting information

  @functional
  Scenario: Confirm quote submission success
    Given I open the tradehub website
    When I navigate to the tender page
    And I click on the quote button
    And I enter a valid price in the price field
    And I enter a valid message in the message field
    And I upload a supporting document
    And I click on the submit button
    Then I see a confirmation message indicating successful quote submission

  @functional
  Scenario: Open tender posted by own account
    Given I open the tradehub website
    When I navigate to the tender page
    And I click on the tender I posted
    Then I see the tender details page

  @functional
  Scenario: View received quotes
    Given I open the TradeHub website
    When I navigate to the Quotes section
    Then I see a list of received quotes

  @functional
  Scenario: Open a specific received quote
    Given I open the TradeHub website
    When I navigate to the Quotes section
    And I select a specific received quote
    Then I see the details of the selected quote

  @functional
  Scenario: Check business profile information in received quote
    Given I open the TradeHub website
    When I navigate to the Quotes section
    And I select a specific received quote
    Then I see the correct business profile information in the quote

  @functional
  Scenario: Check quoted amount in received quote
    Given I open the TradeHub website
    When I navigate to the Quotes section
    And I select a specific received quote
    Then I see the correct quoted amount in the quote

  @functional
  Scenario: Contact quoting business
    Given I open the TradeHub website
    When I navigate to the Quotes section
    And I select a specific received quote
    And I click on the Contact button
    Then I see the contact information for the quoting business

  @functional
  Scenario: Check business profile information for unrelated trades
    Given I open the TradeHub website
    When I navigate to the Quotes section
    And I select a specific received quote
    Then I do not see restricted trade information for businesses with unrelated trades

  @functional
  Scenario: Check quoted amount for unrelated trades
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    And I click on "Login"
    And I enter "<RANDOM:8>" as Username
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    And I click on "Browse Tenders"
    And I select a tender with unrelated trades
    Then I do not see "Restricted Trade Information"

  @functional
  Scenario: Check message for unrelated trades
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    And I click on "Login"
    And I enter "<RANDOM:8>" as Username
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    And I click on "Browse Tenders"
    And I select a tender with unrelated trades
    Then I do not see "Restricted Trade Information"

  @functional
  Scenario: Check supporting information for unrelated trades
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    And I click on "Login"
    And I enter "<RANDOM:8>" as Username
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    And I click on "Browse Tenders"
    And I select a tender with unrelated trades
    Then I do not see "Restricted Trade Information"

  @functional
  Scenario: Check submission rate limits
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    And I click on "Login"
    And I enter "<RANDOM:8>" as Username
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    And I click on "Browse Tenders"
    And I select a tender
    And I click on "Quote"
    And I enter "<RANDOM:8>" as Quote Amount
    And I click on "Submit Quote"
    And I wait for 1 minute
    And I click on "Quote"
    And I enter "<RANDOM:8>" as Quote Amount
    And I click on "Submit Quote"
    Then I see "Submission Rate Limit Reached"

