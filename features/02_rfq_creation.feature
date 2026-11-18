```gherkin
Feature: Web Automation with Behave

  @happy_path
  Scenario: Create a new RFQ with valid inputs
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

  @negative
  Scenario: Create a new RFQ with invalid priority selection
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" in "Title"
    And I enter "RQ-1234" in "Wings REQ"
    And I select "Invalid Priority" as "Priority"
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
    Then I see "Invalid priority selection" is visible

  @NewRFQCreation
  Scenario: Create a new RFQ with empty title
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" in "Title"
    And I click on "Save without sending"
    Then I see "Title is required" is visible

  @NewRFQCreation
  Scenario: Create a new RFQ with invalid Wings REQ number
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid_req_number" in "Wings REQ"
    And I click on "Save without sending"
    Then I see "Invalid Wings REQ number" is visible

  @negative
  Scenario: Create a new RFQ with invalid Incoterm selection
    Given I open "http://localhost:3131/rfqs/new"
    When I select "Invalid Incoterm" as "Delivery terms"
    And I click on "Save without sending"
    Then I see "Invalid Incoterm" is selected as "Delivery terms"
    And I see an error message indicating invalid Incoterm selection

  @negative
  Scenario: Create a new RFQ with empty part number
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" in "Part Number"
    And I click on "Save without sending"
    Then I see an error message indicating empty part number

  @NewRFQCreation
  Scenario: Create a new RFQ with empty description
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" in "Title"
    And I click on "Save without sending"
    Then I see "Title is required" is visible

  @NewRFQCreation
  Scenario: Create a new RFQ with invalid quantity
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "100" in "Quantity"
    And I click on "Save without sending"
    Then I see "Invalid quantity" is visible

  @negative
  Scenario: Create a new RFQ with invalid unit
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid_unit" in "Unit"
    And I click on "Save without sending"
    Then I see "Invalid unit" is selected as "Unit"

  @negative
  Scenario: Create a new RFQ with empty supplier name
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" in "Supplier Name"
    And I click on "Save without sending"
    Then I see "Supplier Name" is empty

  @NewRFQCreation
  Scenario: Create a new RFQ with empty supplier address
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" in "Supplier Address"
    And I click on "Save without sending"
    Then I see "Supplier Address is required" is visible

  @NewRFQCreation
  Scenario: Create a new RFQ with invalid supplier name
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "InvalidName" in "Supplier Name"
    And I click on "Save without sending"
    Then I see "Invalid supplier name" is visible

  @negative
  Scenario: Create a new RFQ with invalid supplier address
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Invalid Address" in "Supplier Address"
    And I click on "Save without sending"
    Then I see "Invalid address format" is displayed

  @negative
  Scenario: Create a new RFQ with empty note to suppliers
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" in "Note to suppliers"
    And I click on "Save without sending"
    Then I see "Note to suppliers is required" is visible

  @negative
  Scenario: Create a new RFQ with empty internal note
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" in "Internal note"
    And I click on "Save without sending"
    Then I see "Internal note is required" is visible

  @negative
  Scenario: Create a new RFQ with invalid date
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid date" in "Answer by"
    And I click on "NE"
    And I click on "Add a line"
    And I enter "1" in "Line 1"
    And I click on "Save without sending"
    Then I see "Invalid date format" is visible
```