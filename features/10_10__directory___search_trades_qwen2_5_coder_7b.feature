Feature: Web Automation with Behave

  @DirectoryOpenSuccess
  Scenario: Open Directory
    Given I open "https://www.tradehub.com.au/directory"
    Then I see "Directory" page is visible

  @TradeSearchSuccess
  Scenario: Search for a trade
    Given I open "https://www.tradehub.com.au/directory"
    When I enter "<RANDOM:8>" as Search Term
    Then I see search results for trades

  @SuburbSearchSuccess
  Scenario: Search by suburb/location
    Given I open "https://www.tradehub.com.au/directory"
    When I enter "<RANDOM:8>" as Suburb/Location
    Then I see search results for trades in the specified suburb/area

  @ChangeSearchRadiusSuccess
  Scenario: Change distance/radius
    Given I open "https://www.tradehub.com.au/directory"
    When I select "5 km" as Search Radius
    Then I see search results within 5 km radius

  @AvailableDateFilterSuccess
  Scenario: Test available-date filtering
    Given I open "https://www.tradehub.com.au/directory"
    When I select "Upcoming" as Available Date Filter
    Then I see trades with upcoming available dates

  @OpenSeveralProfilesSuccess
  Scenario: Open several profiles
    Given I open "https://www.tradehub.com.au/directory"
    When I click on the first trade profile
    And I click on the second trade profile
    Then I see the profiles of two trades

  @DirectorySearchTrades
  Scenario: Check rates
    Given I open "https://www.tradehub.com.au/trades"
    When I select "Plumbing" as Primary Trade
    And I click on "Search"
    Then I see "Rates" is visible

  @DirectorySearchTrades
  Scenario: Check reviews
    Given I open "https://www.tradehub.com.au/trades"
    When I select "Electrical" as Primary Trade
    And I click on "Search"
    Then I see "Reviews" is visible

  @DirectorySearchTrades
  Scenario: Check available dates
    Given I open "https://www.tradehub.com.au/trades"
    When I select "Carpentry" as Primary Trade
    And I click on "Search"
    Then I see "Available Dates" is visible

  @DirectorySearchTrades
  Scenario: Check profile descriptions
    Given I open "https://www.tradehub.com.au/trades"
    When I select "Painting" as Primary Trade
    And I click on "Search"
    Then I see "Profile Descriptions" is visible

  @DirectorySearchTrades
  Scenario: Contact/message a business
    Given I open "https://www.tradehub.com.au/trades"
    When I select "Plumbing" as Primary Trade
    And I click on "Search"
    And I click on "Contact" for the first trade
    Then I see "Message" is visible

  @DirectorySearchTrades
  Scenario: Confirm that the results make sense based on the filters selected
    Given I open "https://www.tradehub.com.au/trades"
    When I select "Electrical" as Primary Trade
    And I enter "Sydney" as Location
    And I click on "Search"
    Then I see "Search Results" match the filters selected

  @FreeAccountRadiusRestrictions
  Scenario: Check Free account radius restrictions
    Given I open "https://www.tradehub.com.au/register"
    When I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Name
    And I enter "<RANDOM:8>@example.com" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on "Register"
    Then I see "Free account is limited to 15km radius" is visible

  @EmptySearchQuery
  Scenario: Search with an empty query
    Given I open "https://www.tradehub.com.au/search"
    When I enter "" as Search Query
    And I click on "Search"
    Then I see "No results found" is visible

  @NonExistentLocation
  Scenario: Search with a non-existent location
    Given I open "https://www.tradehub.com.au/search"
    When I enter "NonExistentLocation" as Location
    And I click on "Search"
    Then I see "No results found" is visible

  @VeryLargeRadius
  Scenario: Search with a very large radius
    Given I open "https://www.tradehub.com.au/search"
    When I enter "10000" as Radius
    And I click on "Search"
    Then I see "Search results within 10000km" is visible

  @VerySmallRadius
  Scenario: Search with a very small radius
    Given I open "https://www.tradehub.com.au/search"
    When I enter "1" as Radius
    And I click on "Search"
    Then I see "Search results within 1km" is visible

  @NonNumericRadius
  Scenario: Search with a non-numeric radius
    Given I open "https://www.tradehub.com.au/search"
    When I enter "abc" as Radius
    And I click on "Search"
    Then I see "Invalid radius value" is visible

