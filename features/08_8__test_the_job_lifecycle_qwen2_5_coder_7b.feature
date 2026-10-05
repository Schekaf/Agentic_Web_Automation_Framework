Feature: Web Automation with Behave

  @POST_JOB
  Scenario: Business A posts a job
    Given I open "https://www.tradehub.com.au/register"
    When I enter "<RANDOM:8>" as Name
    And I select "Trade Business" as Primary Trade
    And I enter "<RANDOM:8>" as Business Name
    And I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Phone
    And I enter "<RANDOM:8>" as Password
    And I click on Create Account
    And I open "https://www.tradehub.com.au/jobs/post"
    And I enter "<RANDOM:8>" as Job Title
    And I enter "<RANDOM:8>" as Job Description
    And I click on Post Job
    Then I see "Job posted successfully" is visible
    And I see "Status: Pending" is visible

  @APPLY_JOB
  Scenario: Business B applies/responds to the job
    Given I open "https://www.tradehub.com.au/login"
    When I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Password
    And I click on Login
    And I open "https://www.tradehub.com.au/jobs"
    And I click on the job posted by Business A
    And I click on Apply for Job
    Then I see "Application submitted successfully" is visible
    And I see "Status: Pending" is visible

  @SELECT_APPLICANT
  Scenario: Business A selects Business B
    Given I open "https://www.tradehub.com.au/login"
    When I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Password
    And I click on Login
    And I open "https://www.tradehub.com.au/jobs"
    And I click on the job posted by Business A
    And I click on Select Applicant
    And I select "Business B"
    Then I see "Business B selected" is visible
    And I see "Status: Pending" is visible

  @STATUS_PENDING
  Scenario: Job changes to Pending
    Given I open "https://www.tradehub.com.au/login"
    When I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Password
    And I click on Login
    And I open "https://www.tradehub.com.au/jobs"
    And I click on the job posted by Business A
    And I click on Select Applicant
    And I select "Business B"
    Then I see "Status: Pending" is visible

  @ACCEPT_JOB
  Scenario: Business B accepts the job
    Given I open "https://www.tradehub.com.au/login"
    When I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Password
    And I click on Login
    And I open "https://www.tradehub.com.au/jobs"
    And I click on the job posted by Business A
    And I click on Accept Job
    Then I see "Job accepted successfully" is visible
    And I see "Status: Confirmed" is visible

  @CONFIRM_JOB
  Scenario: Business A performs the final confirmation
    Given I open "https://www.tradehub.com.au/login"
    When I enter "<RANDOM:8>" as Email
    And I enter "<RANDOM:8>" as Password
    And I click on Login
    And I open "https://www.tradehub.com.au/jobs"
    And I click on the job posted by Business A
    And I click on Final Confirmation
    Then I see "Job confirmed successfully" is visible
    And I see "Status: Confirmed" is visible

  @STATUS_CONFIRMED
  Scenario: Job becomes Confirmed
    Given I open the TradeHub website
    When Business A logs in
    And Business A navigates to the Job Management page
    And Business A selects a job in the Pending state
    And Business A clicks on the Confirm button
    Then I see the job status is updated to Confirmed

  @MARK_COMPLETED
  Scenario: Job can be marked Completed
    Given I open the TradeHub website
    When Business A logs in
    And Business A navigates to the Job Management page
    And Business A selects a job in the Confirmed state
    And Business A clicks on the Complete button
    Then I see the job status is updated to Completed

  @STATUS_VISIBILITY
  Scenario: Both users see the correct status at every stage
    Given I open the TradeHub website
    When Business A logs in
    And Business A navigates to the Job Management page
    And Business A selects a job in the Open state
    Then I see the job status is Open
    When Business B logs in
    And Business B navigates to the Job Management page
    And Business B selects the same job
    Then I see the job status is Open
    When Business A confirms the job
    And Business A navigates to the Job Management page
    And Business A selects the job
    Then I see the job status is Confirmed
    When Business B navigates to the Job Management page
    And Business B selects the job
    Then I see the job status is Confirmed
    When Business A completes the job
    And Business A navigates to the Job Management page
    And Business A selects the job
    Then I see the job status is Completed
    When Business B navigates to the Job Management page
    And Business B selects the job
    Then I see the job status is Completed

  @NOTIFICATION_GENERATION
  Scenario: Notifications are generated when the status changes
    Given I open the TradeHub website
    When Business A logs in
    And Business A navigates to the Job Management page
    And Business A selects a job in the Open state
    And Business A clicks on the Confirm button
    Then I see a notification indicating the job status has changed to Confirmed
    When Business A completes the job
    And Business A navigates to the Job Management page
    And Business A selects the job
    Then I see a notification indicating the job status has changed to Completed

  @UNAUTHORIZED_POST_JOB
  Scenario: Unauthorized access to post a job
    Given I open the TradeHub website
    When A non-registered user logs in
    And A non-registered user navigates to the Job Management page
    And A non-registered user attempts to post a job
    Then I see an error message indicating unauthorized access

  @INVALID_PAYLOAD_POST_JOB
  Scenario: Invalid payload input for posting a job
    Given I open the TradeHub website
    When A registered user logs in
    And A registered user navigates to the Job Management page
    And A registered user attempts to post a job with an invalid payload
    Then I see an error message indicating invalid payload input

  @UNAUTHORIZED_APPLY_JOB
  Scenario: Unauthorized access to apply/respond to a job
    Given I open the job application page
    When I attempt to apply for the job as an unauthorized user
    Then I receive an error message indicating unauthorized access

  @INVALID_PAYLOAD_APPLY_JOB
  Scenario: Invalid payload input for applying/responding to a job
    Given I open the job application page
    When I submit an invalid payload for applying for the job
    Then I receive an error message indicating invalid payload

  @UNAUTHORIZED_SELECT_APPLICANT
  Scenario: Unauthorized access to select an applicant
    Given I open the job application page
    When I attempt to select an applicant as an unauthorized user
    Then I receive an error message indicating unauthorized access

  @INVALID_PAYLOAD_SELECT_APPLICANT
  Scenario: Invalid payload input for selecting an applicant
    Given I open the job application page
    When I submit an invalid payload for selecting an applicant
    Then I receive an error message indicating invalid payload

  @UNAUTHORIZED_ACCEPT_JOB
  Scenario: Unauthorized access to accept a job
    Given I open the job acceptance page
    When I attempt to accept the job as an unauthorized user
    Then I receive an error message indicating unauthorized access

  @INVALID_PAYLOAD_ACCEPT_JOB
  Scenario: Invalid payload input for accepting a job
    Given I open the job acceptance page
    When I submit an invalid payload for accepting the job
    Then I receive an error message indicating invalid payload

