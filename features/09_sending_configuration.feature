Feature: Sending Configuration

  @SendRfqGraphProvider
  Scenario: Send RFQ with default graph provider
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" in "Title"
    And I enter "RQ-1234" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Boeing 737" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York JFK" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "123456" in "part number"
    And I enter "Part Description" in "description"
    And I enter "10" in "quantity"
    And I enter "Unit" in "unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "sales@supplier.com; several with ;"
    And I enter "Internal note for the team" in "Internal note"
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @SendRfqSmtpProvider
  Scenario: Send RFQ with SMTP provider
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" in "Title"
    And I enter "RQ-1234" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Boeing 737" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York JFK" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "123456" in "part number"
    And I enter "Part Description" in "description"
    And I enter "10" in "quantity"
    And I enter "Unit" in "unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "sales@supplier.com; several with ;"
    And I enter "Internal note for the team" in "Internal note"
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @RejectRfqInvalidSmtpCreds
  Scenario: Send RFQ with invalid SMTP credentials
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid_smtp_user" as SMTP Username
    And I enter "invalid_smtp_password" as SMTP Password
    And I click on "Send RFQ"
    Then I see "Invalid SMTP credentials" is visible

  @RejectRfqEmptyFrom
  Scenario: Send RFQ with empty FROM address
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" as FROM address
    And I click on "Send RFQ"
    Then I see "FROM address is required" is visible

  @SendRfqMaxLineItems
  Scenario: Send RFQ with maximum line items
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" in "Title"
    And I enter "RQ-1234" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Boeing 737" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York JFK" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "123456" in "part number"
    And I enter "Part Description" in "description"
    And I enter "10" in "quantity"
    And I enter "Unit" in "unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "sales@supplier.com; several with ;"
    And I enter "Internal note for the team" in "Internal note"
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @RejectRfqZeroLineItems
  Scenario: Send RFQ with zero line items
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" in "Title"
    And I enter "RQ-1234" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Boeing 737" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York JFK" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

