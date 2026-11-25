Feature: RFQ and Quote Process Overview

  @CreateRfqSingleSupplier
  Scenario: Create RFQ with single supplier
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
    And I click on "NE"
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

  @CreateRfqMultipleSuppliers
  Scenario: Create RFQ with multiple suppliers
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
    And I click on "NE"
    And I click on "Add a line"
    And I enter "123456" in "part number"
    And I enter "Part Description" in "description"
    And I enter "10" in "quantity"
    And I enter "Unit" in "unit"
    And I click on "Add a supplier"
    And I enter "supplier1@company.com" in "sales@supplier.com; several with ;"
    And I click on "Add a supplier"
    And I enter "supplier2@company.com" in "sales@supplier.com; several with ;"
    And I enter "Internal note for the team" in "Internal note"
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @RejectEmptyRfqLines
  Scenario: Create RFQ with empty lines
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I click on "Add a line"
    And I click on "Save without sending"
    Then I see "RFQ cannot be submitted without line items" is visible

  @RejectInvalidSupplier
  Scenario: Create RFQ with invalid supplier
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid-email@domain.com" as Supplier Email
    And I click on "Add a line"
    And I click on "Save without sending"
    Then I see "Invalid supplier email" is visible

  @CreateRfqMaxLineItems
  Scenario: Create RFQ with max line items
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "100" in "Line 1"
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @CreateRfqZeroLineItems
  Scenario: Create RFQ with zero line items
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Save without sending"
    Then I see "At least one line item is required" is visible

  @CreateRfqMaxSuppliers
  Scenario: Create RFQ with max suppliers
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
    And I click on "NE"
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

  @CreateRfqZeroSuppliers
  Scenario: Create RFQ with zero suppliers
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
    And I click on "NE"
    And I click on "Add a line"
    And I enter "123456" in "part number"
    And I enter "Part Description" in "description"
    And I enter "10" in "quantity"
    And I enter "Unit" in "unit"
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @UpdateRfqAddSupplier
  Scenario: Update RFQ with new supplier
    Given I open "http://localhost:3131/rfqs/12345"
    When I click on "Add a supplier"
    And I enter "supplier@company.com" in "sales@supplier.com; several with ;"
    And I click on "Save without sending"
    Then I see "RFQ updated successfully" is visible

  @UpdateRfqRemoveSupplier
  Scenario: Update RFQ with removed supplier
    Given I open "http://localhost:3131/rfqs/12345"
    When I click on "Remove supplier"
    And I click on "Save without sending"
    Then I see "RFQ updated successfully" is visible

  @RejectInvalidSupplierUpdate
  Scenario: Update RFQ with invalid supplier
    Given I open "http://localhost:3131/rfqs/12345"
    When I enter "invalid_supplier@company.com" as Supplier Email
    Then I see "Invalid supplier email" is visible

  @UpdateRfqMaxSuppliers
  Scenario: Update RFQ with max suppliers
    Given I open "http://localhost:3131/rfqs/12345"
    When I click on "Add a supplier"
    And I enter "supplier1@company.com" as Supplier Email
    And I click on "Add a supplier"
    And I enter "supplier2@company.com" as Supplier Email
    And I click on "Add a supplier"
    And I enter "supplier3@company.com" as Supplier Email
    Then I see "Maximum suppliers reached" is visible

