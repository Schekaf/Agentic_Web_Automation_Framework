Feature: Web Automation with Behave

  @PostJobHappyPathTitle
  Scenario: Enter a valid job title
    Given I open "https://www.tradehub.com.au/post-job"
    When I enter "<RANDOM:8>" as Job Title
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:50>" as Description
    And I click on "Post Job"
    Then I see "Job posted successfully" is visible

  @PostJobNegativePathTitle
  Scenario: Enter an invalid job title (exceeding 8 words)
    Given I open "https://www.tradehub.com.au/post-job"
    When I enter "<RANDOM:9>" as Job Title
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:50>" as Description
    And I click on "Post Job"
    Then I see "Job title must be between 8 and 50 characters" is visible

  @PostJobHappyPathTrade
  Scenario: Select a valid trade
    Given I open "https://www.tradehub.com.au/post-job"
    When I enter "<RANDOM:8>" as Job Title
    And I select "Electrical" as Primary Trade
    And I enter "<RANDOM:50>" as Description
    And I click on "Post Job"
    Then I see "Job posted successfully" is visible

  @PostJobNegativePathTrade
  Scenario: Select an invalid trade
    Given I open "https://www.tradehub.com.au/post-job"
    When I enter "<RANDOM:8>" as Job Title
    And I select "Invalid Trade" as Primary Trade
    And I enter "<RANDOM:50>" as Description
    And I click on "Post Job"
    Then I see "Invalid trade selection" is visible

  @PostJobHappyPathDescription
  Scenario: Enter a detailed description
    Given I open "https://www.tradehub.com.au/post-job"
    When I enter "<RANDOM:8>" as Job Title
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:100>" as Description
    And I click on "Post Job"
    Then I see "Job posted successfully" is visible

  @PostJobNegativePathDescription
  Scenario: Enter an empty description
    Given I open "https://www.tradehub.com.au/post-job"
    When I enter "<RANDOM:8>" as Job Title
    And I select "Trade Business" as Primary Trade
    And I enter "" as Description
    And I click on "Post Job"
    Then I see "Description cannot be empty" is visible

  @location
  Scenario: Enter a job location
    Given I open "https://www.tradehub.com.au/post-job"
    When I enter "Sydney" as Job Location
    Then I see "Job Location" is "Sydney"

  @location
  Scenario: Enter an invalid job location
    Given I open "https://www.tradehub.com.au/post-job"
    When I enter "InvalidLocation123" as Job Location
    Then I see "Invalid Job Location" error message

  @date
  Scenario: Enter a valid date
    Given I open "https://www.tradehub.com.au/post-job"
    When I enter "<TODAY>" as Job Date
    Then I see "Job Date" is "<TODAY>"

  @date
  Scenario: Enter an invalid date
    Given I open "https://www.tradehub.com.au/post-job"
    When I enter "2023-13-01" as Job Date
    Then I see "Invalid Job Date" error message

  @duration
  Scenario: Enter a valid expected duration
    Given I open "https://www.tradehub.com.au/post-job"
    When I enter "2 days" as Expected Duration
    Then I see "Expected Duration" is "2 days"

  @duration
  Scenario: Enter an invalid expected duration
    Given I open "https://www.tradehub.com.au/post-job"
    When I enter "InvalidDuration" as Expected Duration
    Then I see "Invalid Expected Duration" error message

  @rate
  Scenario: Enter a valid rate/budget
    Given I open "https://www.tradehub.com.au/post-job"
    When I enter "100" as Rate/Budget
    Then I see "Rate/Budget saved successfully" is visible

  @rate
  Scenario: Enter an invalid rate/budget
    Given I open "https://www.tradehub.com.au/post-job"
    When I enter "abc" as Rate/Budget
    Then I see "Invalid Rate/Budget" is visible

  @tag
  Scenario: Add an emergency/urgent tag
    Given I open "https://www.tradehub.com.au/post-job"
    When I select "Urgent" as Tag
    Then I see "Urgent" is selected as Tag

  @tag
  Scenario: Do not add an emergency/urgent tag
    Given I open "https://www.tradehub.com.au/post-job"
    When I do not select any Tag
    Then I do not see any Tag selected

  @attachment
  Scenario: Upload a valid attachment/photo
    Given I open "https://www.tradehub.com.au/post-job"
    When I upload a valid image file as Attachment/Photo
    Then I see "Attachment/Photo uploaded successfully" is visible

  @attachment
  Scenario: Upload an invalid attachment/photo
    Given I open "https://www.tradehub.com.au/post-job"
    When I upload an invalid file as Attachment/Photo
    Then I see "Invalid file type" is visible

  @submission
  Scenario: Submit the job
    Given I open "https://www.tradehub.com.au/post-job"
    When I enter "<RANDOM:8>" as Job Title
    And I enter "<RANDOM:8>" as Description
    And I select "Plumbing" as Primary Trade
    And I enter "<RANDOM:8>" as Location
    And I enter "<RANDOM:8>" as Budget
    And I click on "Submit Job"
    Then I see "Job submitted successfully" is visible

  @account
  Scenario: Confirm job appears in account
    Given I open "https://www.tradehub.com.au/login"
    When I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Password
    And I click on "Login"
    Then I see "Dashboard" is visible
    And I see "Posted Jobs" is visible
    And I see the job I submitted is listed in "Posted Jobs"

