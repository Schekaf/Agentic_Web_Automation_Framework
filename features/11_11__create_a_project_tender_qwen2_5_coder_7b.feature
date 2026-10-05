Feature: Web Automation with Behave

  @Positive
  Scenario: Enter project name
    Given I open the project tender page
    When I enter "ValidProjectName" in the project name field
    Then I see the project name is saved successfully

  @Negative
  Scenario: Enter project name with invalid characters
    Given I open the project tender page
    When I enter "Invalid@ProjectName" in the project name field
    Then I see an error message indicating invalid characters

  @Boundary
  Scenario: Enter project name with maximum character limit
    Given I open the project tender page
    When I enter "<RANDOM:100>" in the project name field
    Then I see the project name is saved successfully

  @Negative
  Scenario: Enter project name with empty string
    Given I open the project tender page
    When I enter an empty string in the project name field
    Then I see an error message indicating empty project name

  @Positive
  Scenario: Enter project location
    Given I open the project tender page
    When I enter "ValidLocation" in the project location field
    Then I see the project location is saved successfully

  @Negative
  Scenario: Enter project location with invalid characters
    Given I open the project tender page
    When I enter "Invalid@Location" in the project location field
    Then I see an error message indicating invalid characters

  @Boundary
  Scenario: Enter project location with maximum character limit
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:80>" as Project Location
    Then I see "Project location is valid" is visible

  @Negative
  Scenario: Enter project location with empty string
    Given I open "https://www.tradehub.com.au/register"
    When I enter "" as Project Location
    Then I see "Project location is required" is visible

  @Positive
  Scenario: Enter project dates
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<TODAY>" as Start Date
    And I enter "<TODAY>" as End Date
    Then I see "Project dates are valid" is visible

  @Negative
  Scenario: Enter project dates with invalid format
    Given I open "https://www.tradehub.com.au/register"
    When I enter "2023-13-01" as Start Date
    And I enter "2023-13-01" as End Date
    Then I see "Project dates are invalid" is visible

  @Negative
  Scenario: Enter project dates with future dates
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<TODAY>" as Start Date
    And I enter "<TODAY> + 1 day" as End Date
    Then I see "Project dates are invalid" is visible

  @Negative
  Scenario: Enter project dates with past dates
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<TODAY> - 1 day" as Start Date
    And I enter "<TODAY> - 1 day" as End Date
    Then I see "Project dates are invalid" is visible

  @Positive
  Scenario: Add overall project description
    Given I open the project tender page
    When I enter a valid overall project description
    Then I see the project description is saved successfully

  @Boundary
  Scenario: Add overall project description with maximum character limit
    Given I open the project tender page
    When I enter the maximum allowed characters for the overall project description
    Then I see the project description is saved successfully

  @Negative
  Scenario: Add overall project description with empty string
    Given I open the project tender page
    When I enter an empty string for the overall project description
    Then I see an error message indicating that the description cannot be empty

  @Positive
  Scenario: Upload plans
    Given I open the project tender page
    When I upload valid plans
    Then I see the plans are uploaded successfully

  @Negative
  Scenario: Upload plans with invalid file type
    Given I open the project tender page
    When I upload plans with an invalid file type
    Then I see an error message indicating that the file type is not allowed

  @Positive
  Scenario: Select multiple required trades
    Given I open the project tender page
    When I select multiple required trades
    Then I see the selected trades are saved successfully

  @Positive
  Scenario: Enter separate description for each trade
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on Create Account
    And I click on "Create Tender"
    And I enter "<RANDOM:8>" as Tender Title
    And I enter "<RANDOM:8>" as Description for Plumbing
    And I enter "<RANDOM:8>" as Description for Electrical
    And I enter "<RANDOM:8>" as Description for Carpentry
    And I enter "<RANDOM:8>" as Description for Painting
    And I click on "Submit Tender"
    Then I see "Tender Created Successfully" is visible

  @Negative
  Scenario: Enter budget for each trade with negative value
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on Create Account
    And I click on "Create Tender"
    And I enter "<RANDOM:8>" as Tender Title
    And I enter "<RANDOM:8>" as Description for Plumbing
    And I enter "<RANDOM:8>" as Description for Electrical
    And I enter "<RANDOM:8>" as Description for Carpentry
    And I enter "<RANDOM:8>" as Description for Painting
    And I enter "-1000" as Budget for Plumbing
    And I enter "-500" as Budget for Electrical
    And I enter "-200" as Budget for Carpentry
    And I enter "-100" as Budget for Painting
    And I click on "Submit Tender"
    Then I see "Invalid Budget Value" is visible

