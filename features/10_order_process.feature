Feature: Web Automation with Behave

  @Positive
  Scenario: Create a new RFQ with valid data
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" in "Title"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "A380" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "Part123" in "Part number"
    And I enter "Description1" in "Description"
    And I enter "10" in "Quantity"
    And I enter "Unit1" in "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "Email"
    And I enter "Internal note for the team" in "Internal note"
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @Negative
  Scenario: Create a new RFQ with an empty title
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" in "Title"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "A380" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "Part123" in "Part number"
    And I enter "Description1" in "Description"
    And I enter "10" in "Quantity"
    And I enter "Unit1" in "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "Email"
    And I enter "Internal note for the team" in "Internal note"
    And I click on "Save without sending"
    Then I see "Title is required" is visible

  @Negative
  Scenario: Create a new RFQ with a title exceeding 8 words
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "This is a very long title that exceeds eight words" in "Title"
    And I click on "Save without sending"
    Then I see "Title must be 8 words or less" is visible

  @Positive
  Scenario: Create a new RFQ with a title of 8 words
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "This is a title of exactly eight words" in "Title"
    And I click on "Save without sending"
    Then I do not see "Title must be 8 words or less" is visible

  @Positive
  Scenario: Create a new RFQ with a valid Wings REQ
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" in "Title"
    And I enter "RQ-12345" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "AW139" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "Part123" in "part number"
    And I enter "Description1" in "description"
    And I enter "10" in "quantity"
    And I enter "Unit1" in "unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "sales@supplier.com; several with ;"
    And I enter "Internal note for the team" in "Internal note"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Negative
  Scenario: Create a new RFQ with an invalid Wings REQ
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" in "Title"
    And I enter "InvalidREQ" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "AW139" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "Part123" in "part number"
    And I enter "Description1" in "description"
    And I enter "10" in "quantity"
    And I enter "Unit1" in "unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "sales@supplier.com; several with ;"
    And I enter "Internal note for the team" in "Internal note"
    And I click on "Save without sending"
    Then I see "Invalid Wings REQ" is visible

  @Positive
  Scenario: Create a new RFQ with a valid priority
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" in "Title"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Negative
  Scenario: Create a new RFQ with an invalid priority
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" in "Title"
    And I select "Invalid Priority" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I click on "Save without sending"
    Then I see "Invalid priority selected" is visible

  @Positive
  Scenario: Create a new RFQ with a valid answer by date
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" in "Title"
    And I enter "RQ-1234" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I click on "Add a line"
    And I enter "Part123" in "Part Number"
    And I enter "Description1" in "Description"
    And I enter "10" in "Quantity"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Negative
  Scenario: Create a new RFQ with an invalid answer by date
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" in "Title"
    And I enter "RQ-1234" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2022-12-31" in "Answer by"
    And I click on "Add a line"
    And I enter "Part123" in "Part Number"
    And I enter "Description1" in "Description"
    And I enter "10" in "Quantity"
    And I click on "Save without sending"
    Then I see "Invalid answer by date" is visible

  @Positive
  Scenario: Create a new RFQ with a valid aircraft
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139" in "Aircraft"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Negative
  Scenario: Create a new RFQ with an invalid aircraft
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "InvalidAircraft" in "Aircraft"
    And I click on "Save without sending"
    Then I see "Invalid aircraft model" is visible

  @Positive
  Scenario: Create a new RFQ with a valid note to suppliers
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Valid Note" in "Note to suppliers"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Negative
  Scenario: Create a new RFQ with an invalid note to suppliers
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Invalid Note" in "Note to suppliers"
    And I click on "Save without sending"
    Then I see "Invalid note error message" is visible

  @Positive
  Scenario: Create a new RFQ with a valid delivery terms
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" in "Title"
    And I enter "AW139 C-check parts" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Boeing 737" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "Part123" in "part number"
    And I enter "Description1" in "description"
    And I enter "10" in "quantity"
    And I enter "Unit1" in "unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "sales@supplier.com; several with ;"
    And I enter "Internal note for the team" in "Internal note"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Negative
  Scenario: Create a new RFQ with an invalid delivery terms
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" in "Title"
    And I enter "AW139 C-check parts" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Boeing 737" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "Invalid Delivery Term" as "Delivery terms"
    And I enter "New York" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "Part123" in "part number"
    And I enter "Description1" in "description"
    And I enter "10" in "quantity"
    And I enter "Unit1" in "unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "sales@supplier.com; several with ;"
    And I enter "Internal note for the team" in "Internal note"
    And I click on "Save without sending"
    Then I see "Invalid delivery terms" is visible

  @Positive
  Scenario: Create a new RFQ with a valid incoterm
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" in "Title"
    And I enter "AW139 C-check parts" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Boeing 737" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York" in "named place"
    And I select "Outright purchase" as "Purchase type"
    And I click on "Add a line"
    And I enter "Part123" in "Part number"
    And I enter "Description1" in "Description"
    And I enter "10" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "Email"
    And I enter "Internal note for the team" in "Internal note"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Negative
  Scenario: Create a new RFQ with an invalid incoterm
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" in "Title"
    And I enter "AW139 C-check parts" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Boeing 737" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "Invalid Incoterm" as "Delivery terms"
    And I enter "New York" in "named place"
    And I select "Outright purchase" as "Purchase type"
    And I click on "Add a line"
    And I enter "Part123" in "Part number"
    And I enter "Description1" in "Description"
    And I enter "10" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "Email"
    And I enter "Internal note for the team" in "Internal note"
    And I click on "Save without sending"
    Then I see "Invalid incoterm" is selected as "Delivery terms"
    And I see "Invalid incoterm" is visible

  @Positive
  Scenario: Create a new RFQ with a valid incoterm place
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" in "Title"
    And I enter "AW139 C-check parts" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Boeing 737" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York" in "named place"
    And I select "Outright purchase" as "Purchase type"
    And I click on "Add a line"
    And I enter "Part123" in "Part number"
    And I enter "Description1" in "Description"
    And I enter "10" in "Quantity"
    And I enter "Unit1" in "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "Email"
    And I enter "Internal note for the team" in "Internal note"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Negative
  Scenario: Create a new RFQ with an invalid incoterm place
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" in "Title"
    And I enter "AW139 C-check parts" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Boeing 737" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "Invalid Incoterm" as "Delivery terms"
    And I enter "New York" in "named place"
    And I select "Outright purchase" as "Purchase type"
    And I click on "Add a line"
    And I enter "Part123" in "Part number"
    And I enter "Description1" in "Description"
    And I enter "10" in "Quantity"
    And I enter "Unit1" in "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "Email"
    And I enter "Internal note for the team" in "Internal note"
    And I click on "Save without sending"
    Then I see "Invalid incoterm place" is visible

  @Positive
  Scenario: Create a new RFQ with a valid exchange term
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" in "Title"
    And I enter "AW139 C-check parts" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Boeing 737" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York" in "named place"
    And I select "Exchange" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "Part123" in "part number"
    And I enter "Description1" in "description"
    And I enter "10" in "quantity"
    And I enter "Unit1" in "unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "sales@supplier.com; several with ;"
    And I enter "Internal note for the team" in "Internal note"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Negative
  Scenario: Create a new RFQ with an invalid exchange term
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" in "Title"
    And I enter "AW139 C-check parts" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Boeing 737" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York" in "named place"
    And I select "Exchange" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "Part123" in "part number"
    And I enter "Description1" in "description"
    And I enter "10" in "quantity"
    And I enter "Unit1" in "unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "sales@supplier.com; several with ;"
    And I enter "Internal note for the team" in "Internal note"
    And I click on "Save without sending"
    Then I see "Invalid exchange term" is visible

  @Positive
  Scenario: Create a new RFQ with a valid supplier
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Valid Supplier Name" in "Title"
    And I enter "Valid Supplier Email" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Aircraft Model" in "Aircraft"
    And I enter "Note for Suppliers" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "Named Place" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "Part Number" in "Part Number"
    And I enter "Description" in "Description"
    And I enter "Quantity" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Add a supplier"
    And I enter "Supplier Name" in "Supplier Name"
    And I enter "Supplier Email" in "Supplier Email"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Negative
  Scenario: Create a new RFQ with an invalid supplier
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Invalid Supplier Name" in "Title"
    And I enter "Invalid Supplier Email" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Aircraft Model" in "Aircraft"
    And I enter "Note for Suppliers" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "Named Place" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "Part Number" in "Part Number"
    And I enter "Description" in "Description"
    And I enter "Quantity" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Add a supplier"
    And I enter "Invalid Supplier Name" in "Supplier Name"
    And I enter "Invalid Supplier Email" in "Supplier Email"
    And I click on "Save without sending"
    Then I see "Invalid supplier error message" is visible

  @Positive
  Scenario: Create a new RFQ with a valid internal note
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" in "Title"
    And I enter "AOG" in "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "A320" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "Part123" in "Part Number"
    And I enter "Description1" in "Description"
    And I enter "10" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "Email"
    And I enter "Internal note for RFQ" in "Internal note"
    Then I see "Save without sending" is "Visible"

