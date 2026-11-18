Feature: Web Automation with Behave

  @default_provider
  Scenario: Sending Configuration
    Given I open "http://localhost:3131/rfqs/new"
    When I select "graph" as "MAIL_SEND_PROVIDER"
    And I enter "default@example.com" as "MAILBOX_ADDRESS"
    Then I see "default@example.com" is selected as "MAILBOX_ADDRESS"

  @smtp_valid_credentials
  Scenario: Sending Configuration
    Given I open "http://localhost:3131/rfqs/new"
    When I select "SMTP" as "MAIL_SEND_PROVIDER"
    And I enter "smtp.example.com" as "SMTP_HOST"
    And I enter "587" as "SMTP_PORT"
    And I enter "user@example.com" as "SMTP_USER"
    And I enter "password123" as "SMTP_PASSWORD"
    Then I see "SMTP" is selected as "MAIL_SEND_PROVIDER"
    And I see "smtp.example.com" is selected as "SMTP_HOST"
    And I see "587" is selected as "SMTP_PORT"
    And I see "user@example.com" is selected as "SMTP_USER"
    And I see "password123" is selected as "SMTP_PASSWORD"

  @smtp_invalid_credentials
  Scenario: SMTP configuration with invalid credentials
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid_username" as "SMTP Username"
    And I enter "invalid_password" as "SMTP Password"
    And I click on "Save without sending"
    Then I see "Invalid credentials" error message is visible

  @microsoft_365_permission
  Scenario: Sending with Microsoft 365 provider and application permission
    Given I open "http://localhost:3131/rfqs/new"
    When I select "Microsoft 365" as "SMTP Provider"
    And I enter "valid_username" as "SMTP Username"
    And I enter "valid_password" as "SMTP Password"
    And I click on "Save without sending"
    Then I see "Email sent successfully" message is visible

  microsoft_365_no_permission
  Scenario: Sending with Microsoft 365 provider without application permission
    Given I open "http://localhost:3131/rfqs/new"
    When I select "Microsoft 365" as "Provider"
    And I click on "Send"
    Then I see "Permission denied" is visible

  no_configuration
  Scenario: Sending with no configuration
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Send"
    Then I see "Configuration required" is visible

  @empty_mail_from
  Scenario: Sending with empty MAIL_FROM
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" as "MAIL_FROM"
    And I click on "Send"
    Then I see "Error: MAIL_FROM cannot be empty" is visible

  @null_mail_from
  Scenario: Sending with null MAIL_FROM
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "null" as "MAIL_FROM"
    And I click on "Send"
    Then I see "Error: MAIL_FROM cannot be null" is visible

  long_mail_from
  Scenario: Sending with long MAIL_FROM
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>@example.com" as "MAIL_FROM"
    Then I see "Invalid MAIL_FROM length" error message

  valid_mail_from_name
  Scenario: Sending with valid MAIL_FROM_NAME
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "John Doe" as "MAIL_FROM_NAME"
    And I enter "<RANDOM:8>@example.com" as "MAIL_FROM"
    And I enter "Test RFQ" as "Title"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" as "Answer by"
    And I enter "A320" as "Aircraft"
    And I enter "Shipping to another base" as "Note to suppliers"
    And I select "EXW" as "Incoterm"
    And I enter "New York" as "named place"
    And I select "Outright purchase" as "Purchase type"
    And I click on "Add a line"
    And I enter "Part123" as "Part number"
    And I enter "Description" as "Description"
    And I enter "10" as "Quantity"
    And I enter "Unit" as "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as "Supplier email"
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" message

  invalid_mail_from_name
  Scenario: Sending with invalid MAIL_FROM_NAME
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid@" as "MAIL_FROM_NAME"
    And I click on "Send" button
    Then I see "Invalid MAIL_FROM_NAME" error message

  empty_title
  Scenario: Sending with empty TITLE
    Given I open "http://localhost:3131/rfqs/new"
    When I leave "TITLE" as empty
    And I click on "Send" button
    Then I see "Empty TITLE" error message

  @null_title
  Scenario: Sending with null TITLE
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" as "Title"
    And I click on "Save without sending"
    Then I see "Title is required" is visible

  @long_title
  Scenario: Sending with long TITLE
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "A very long title that exceeds the maximum allowed length of 255 characters" as "Title"
    And I click on "Save without sending"
    Then I see "Title is too long" is visible

  valid_priority
  Scenario: Sending with valid PRIORITY
    Given I open "http://localhost:3131/rfqs/new"
    When I select "AOG" as "Priority *"
    And I enter "<RANDOM:8>" as "Title"
    And I enter "<RANDOM:8>" as "Wings REQ"
    And I enter "<RANDOM:8>" as "Answer by"
    And I enter "<RANDOM:8>" as "Aircraft"
    And I enter "<RANDOM:8>" as "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "<RANDOM:8>" as "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "<RANDOM:8>" as "Part number"
    And I enter "<RANDOM:8>" as "Description"
    And I enter "1" as "Quantity"
    And I enter "Unit" as "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@domain.com" as "Email"
    And I enter "<RANDOM:8>" as "Internal note"
    Then I see "Save without sending" is "Visible"

  invalid_priority
  Scenario: Sending with invalid PRIORITY
    Given I open "http://localhost:3131/rfqs/new"
    When I select "Invalid Priority" as "Priority *"
    And I enter "<RANDOM:8>" as "Title"
    And I enter "<RANDOM:8>" as "Wings REQ"
    And I enter "<RANDOM:8>" as "Answer by"
    And I enter "<RANDOM:8>" as "Aircraft"
    And I enter "<RANDOM:8>" as "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "<RANDOM:8>" as "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "<RANDOM:8>" as "Part number"
    And I enter "<RANDOM:8>" as "Description"
    And I enter "1" as "Quantity"
    And I enter "Unit" as "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@domain.com" as "Email"
    And I enter "<RANDOM:8>" as "Internal note"
    Then I see "Save without sending" is "Visible"

  empty_answer_by
  Scenario: Sending with empty ANSWER_BY
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" as "Answer by"
    And I click on "Save without sending"
    Then I see "Answer by" is "required"

  null_answer_by
  Scenario: Sending with null ANSWER_BY
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "null" as "Answer by"
    And I click on "Save without sending"
    Then I see "Answer by" is "required"

  long_answer_by
  Scenario: Sending with long ANSWER_BY
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" as "Answer by"
    Then I see "Answer by" is "Invalid"

  valid_aircraft
  Scenario: Sending with valid AIRCRAFT
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139" as "Aircraft"
    Then I see "Aircraft" is "Valid"

  @invalid_aircraft
  Scenario: Sending with invalid AIRCRAFT
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid_aircraft" as "Aircraft"
    And I click on "Save without sending"
    Then I see "Invalid Aircraft" is "error"

  @empty_note_to_suppliers
  Scenario: Sending with empty NOTE_TO_SUPPLIERS
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" as "Note to suppliers"
    And I click on "Save without sending"
    Then I see "Empty Note to Suppliers" is "error"

  @null_note_to_suppliers
  Scenario: Sending with null NOTE_TO_SUPPLIERS
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" as "Note to suppliers"
    And I click on "Save without sending"
    Then I see "Error: NOTE_TO_SUPPLIERS cannot be null" is visible

  @long_note_to_suppliers
  Scenario: Sending with long NOTE_TO_SUPPLIERS
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:1000>" as "Note to suppliers"
    And I click on "Save without sending"
    Then I see "Error: NOTE_TO_SUPPLIERS exceeds maximum length" is visible

  @valid_incoterm
  Scenario: Sending with valid INCOTERM and named place
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as "Title"
    And I enter "AW139 C-check parts" as "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" as "Answer by"
    And I enter "Boeing 737" as "Aircraft"
    And I enter "Shipping to another base" as "Note to suppliers"
    And I select "FCA" as "Delivery terms"
    And I enter "Newark International Airport" as "named place"
    And I select "Outright purchase" as "Purchase type"
    And I click on "Add a line"
    And I enter "123456" as "Part number"
    And I enter "Engine" as "Description"
    And I enter "10" as "Quantity"
    And I enter "Each" as "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as "Email"
    And I enter "Internal note for the team" as "Internal note"
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible