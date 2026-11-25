Feature: Mail Content and Sending

  @SendValidMail
  Scenario: Send mail with valid Incoterm and line items
    Given I open "http://localhost:3131"
    When I click on "Send Mail"
    And I enter "valid_incoterm" as Incoterm
    And I enter "line_item_1" as Line Item 1
    And I click on "Send"
    Then I see "Mail sent successfully" is visible

  @RejectEmptyLineItems
  Scenario: Send mail with empty line items
    Given I open "http://localhost:3131"
    When I click on "Send Mail"
    And I click on "Send"
    Then I see "Line items cannot be empty" is visible

  @RejectInvalidIncoterm
  Scenario: Send mail with invalid Incoterm
    Given I open "http://localhost:3131"
    When I enter "invalid_incoterm" as Incoterm
    Then I see "Invalid Incoterm" is visible

  @SendMailMaxLineItems
  Scenario: Send mail with max number of line items
    Given I open "http://localhost:3131"
    When I click on "Add a line"
    And I enter "100" in "Line 1"
    Then I see "Max line items reached" is visible

  @RejectZeroLineItems
  Scenario: Send mail with zero line items
    Given I open "http://localhost:3131"
    When I click on "Send Mail"
    And I click on "Add a line"
    And I click on "Add a line"
    And I click on "Send Mail"
    Then I see "Mail cannot be sent with zero line items" is visible

  @RejectNegativeQuantity
  Scenario: Send mail with negative quantity
    Given I open "http://localhost:3131"
    When I click on "Send Mail"
    And I click on "Add a line"
    And I enter "-1" in "quantity"
    And I click on "Send Mail"
    Then I see "Negative quantity is not allowed" is visible

  @SendMailMaxPrice
  Scenario: Send mail with max price value
    Given I open "http://localhost:3131"
    When I enter "<RANDOM:8>" as Title
    And I enter "<RANDOM:8>" as Wings REQ
    And I select "AOG" as Priority
    And I enter "<TODAY>" as Answer by
    And I enter "<RANDOM:8>" as Aircraft
    And I enter "<RANDOM:8>" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "<RANDOM:8>" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "123456" as part number
    And I enter "Part Description" as description
    And I enter "10" as quantity
    And I enter "Unit" as unit
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as sales@supplier.com; several with ;
    And I enter "Internal note for the team" as Internal note
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @RejectZeroPrice
  Scenario: Send mail with zero price
    Given I open "http://localhost:3131"
    When I enter "<RANDOM:8>" as Title
    And I enter "<RANDOM:8>" as Wings REQ
    And I select "AOG" as Priority
    And I enter "<TODAY>" as Answer by
    And I enter "<RANDOM:8>" as Aircraft
    And I enter "<RANDOM:8>" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "<RANDOM:8>" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "123456" as part number
    And I enter "Part Description" as description
    And I enter "0" as quantity
    And I enter "Unit" as unit
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as sales@supplier.com; several with ;
    And I enter "Internal note for the team" as Internal note
    And I click on "Save without sending"
    Then I see "Invalid quantity" is visible

  @SendAogMailDefaultSettings
  Scenario: Send mail with AOG default settings
    Given I open "http://localhost:3131"
    When I click on "Send Mail"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Boeing 737" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York JFK" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    Then I see "Mail sent successfully" is visible

  @RejectAogSettingsDisabled
  Scenario: Send mail with AOG settings disabled
    Given I open "http://localhost:3131"
    When I click on "Send Mail"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Boeing 737" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York JFK" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Disable AOG Settings"
    Then I see "AOG settings are disabled" is visible
    And I see "Mail submission rejected" is visible

  @RejectMissingReleaseForm
  Scenario: Send mail with missing release form
    Given I open "http://localhost:3131"
    When I click on "Send Mail"
    And I click on "Add Release Form"
    And I click on "Submit Mail"
    Then I see "Release form is required" is visible

  @RejectInvalidReleaseForm
  Scenario: Send mail with invalid release form
    Given I open "http://localhost:3131"
    When I click on "Send Mail"
    And I click on "Add Release Form"
    And I enter "invalid_form" as Release Form
    And I click on "Submit Mail"
    Then I see "Invalid release form" is visible

