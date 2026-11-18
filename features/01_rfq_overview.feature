Feature: Web Automation with Behave
  Background: Login
    Given I open "http://localhost:3131/login"
    When I enter "merve@srm.local" in "Username"
    And I enter "srm-demo" in "Password"
    And I click on "Login"
    Then I see "Welcome, testuser!" is visible

  @Positive
  Scenario: Create a new RFQ with valid data
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" in "Title"
    And I enter "WINGS-1234" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Boeing 737" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York JFK" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "Part123" in "Part Number"
    And I enter "Description1" in "Description"
    And I enter "10" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "Email"
    And I enter "Internal note for the team" in "Internal note"
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @Negative
  Scenario: Create a new RFQ with an empty title
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" in "Title"
    And I enter "WINGS-1234" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Boeing 737" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York JFK" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "Part123" in "Part Number"
    And I enter "Description1" in "Description"
    And I enter "10" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "Email"
    And I enter "Internal note for the team" in "Internal note"
    And I click on "Save without sending"
    Then I see "Title is required" is visible

  @Negative
  Scenario: Create a new RFQ with a title exceeding 8 words
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "This is a title that exceeds eight words" in "Title"
    And I click on "Save without sending"
    Then I see "Title must be 8 words or less" is visible

  @Positive
  Scenario: Create a new RFQ with a priority set to AOG
    Given I open "http://localhost:3131/rfqs/new"
    When I select "AOG" as "Priority"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Positive
  Scenario: Create a new RFQ with a priority set to AOG risk
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" in "Title"
    And I select "AOG risk" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Positive
  Scenario: Create a new RFQ with a priority set to Critical
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" in "Title"
    And I select "Critical" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Positive
  Scenario: Create a new RFQ with a priority set to Routine
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" in "Title"
    And I select "Routine" as "Priority"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Negative
  Scenario: Create a new RFQ with an invalid priority
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" in "Title"
    And I select "Invalid Priority" as "Priority"
    And I click on "Save without sending"
    Then I see "Invalid priority selected" is visible

  @Negative
  Scenario: Create a new RFQ with an empty requisition reference
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" in "Requisition Reference"
    And I click on "Save without sending"
    Then I see "Requisition Reference is required" is visible

  @Negative
  Scenario: Create a new RFQ with a requisition reference exceeding 80 characters
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "This is a very long requisition reference that exceeds the maximum allowed length of 80 characters" in "Requisition Reference"
    And I click on "Save without sending"
    Then I see "Requisition Reference must be 80 characters or less" is visible

  @Negative
  Scenario: Create a new RFQ with an empty aircraft
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" in "Aircraft"
    And I click on "Save without sending"
    Then I see "Aircraft is required" is visible

  @Negative
  Scenario: Create a new RFQ with an aircraft exceeding 80 characters
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "This is a very long aircraft model name that exceeds the 80 character limit" in "Aircraft"
    And I click on "Save without sending"
    Then I see "Aircraft must be 80 characters or less" is visible

  @Negative
  Scenario: Create a new RFQ with an empty note to suppliers
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" in "Note to suppliers"
    And I click on "Save without sending"
    Then I see "Note to suppliers is required" is visible

  @Negative
  Scenario: Create a new RFQ with a note to suppliers exceeding 255 characters
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." in "Note to suppliers"
    And I click on "Save without sending"
    Then I see "Note to suppliers must be 255 characters or less" is visible

  @Negative
  Scenario: Create a new RFQ with an invalid Incoterm
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "INVALID_INCOTERM" in "Delivery terms"
    And I click on "Save without sending"
    Then I see "Invalid Incoterm" is selected as "Delivery terms"

  @Negative
  Scenario: Create a new RFQ with an empty Incoterm place
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" in "named place"
    And I click on "Save without sending"
    Then I see "named place" is empty

  @Negative
  Scenario: Create a new RFQ with an empty delivery terms
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" in "Delivery terms"
    And I click on "Save without sending"
    Then I see "Delivery terms is required" is visible

  @Positive
  Scenario: Create a new RFQ with a line added and a supplier selected
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "Part1" in "Part Number"
    And I enter "Description1" in "Description"
    And I enter "1" in "Quantity"
    And I enter "Unit1" in "Unit"
    And I click on "Add a supplier"
    And I enter "supplier1@example.com" in "Email"
    And I click on "Save without sending"
    Then I see "Line added successfully" is visible
    And I see "supplier1@example.com" in "Suppliers"

  @Negative
  Scenario: Create a new RFQ with a line added and a supplier not selected
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ-123" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "A380" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York" in "named place"
    And I select "Outright purchase" as "Purchase type"
    And I click on "Add a line"
    And I enter "Part123" in "Part number"
    And I enter "Description123" in "Description"
    And I enter "10" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Save without sending"
    Then I see "Supplier is required" is visible

  @Negative
  Scenario: Create a new RFQ with a line added and a supplier selected with an invalid Incoterm
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ-123" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "A380" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York" in "named place"
    And I select "Outright purchase" as "Purchase type"
    And I click on "Add a line"
    And I enter "Part123" in "Part number"
    And I enter "Description123" in "Description"
    And I enter "10" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@supplier.com" in "Email"
    And I click on "Save without sending"
    Then I see "Invalid Incoterm" is visible

  @Negative
  Scenario: Create a new RFQ with a line added and a supplier selected with an empty Incoterm place
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" in "Title"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "A380" in "Aircraft"
    And I enter "Note to suppliers" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "" in "named place"
    And I select "Outright purchase" as "Purchase type"
    And I click on "Add a line"
    And I enter "Part123" in "Part number"
    And I enter "Description123" in "Description"
    And I enter "10" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "Email"
    And I click on "Save without sending"
    Then I see "Incoterm place is required" is visible

  @Negative
  Scenario: Create a new RFQ with a line added and a supplier selected with an empty delivery terms
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" in "Title"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "A380" in "Aircraft"
    And I enter "Note to suppliers" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York" in "named place"
    And I select "" as "Delivery terms"
    And I select "Outright purchase" as "Purchase type"
    And I click on "Add a line"
    And I enter "Part123" in "Part number"
    And I enter "Description123" in "Description"
    And I enter "10" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "Email"
    And I click on "Save without sending"
    Then I see "Delivery terms is required" is visible

  @Negative
  Scenario: Create a new RFQ with a line added and a supplier selected with an invalid delivery terms
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ-123" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "A380" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "Invalid Place" in "named place"
    And I click on "Add a line"
    And I enter "Part123" in "part number"
    And I enter "Description123" in "description"
    And I enter "10" in "quantity"
    And I enter "Unit" in "unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "sales@supplier.com; several with ;"
    And I click on "Save without sending"
    Then I see "Invalid delivery terms" is selected as "Delivery terms"

  @Negative
  Scenario: Create a new RFQ with a line added and a supplier selected with an empty note to suppliers
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ-123" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "A380" in "Aircraft"
    And I enter "" in "Note to suppliers"
    And I click on "Add a line"
    And I enter "Part123" in "part number"
    And I enter "Description123" in "description"
    And I enter "10" in "quantity"
    And I enter "Unit" in "unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "sales@supplier.com; several with ;"
    And I click on "Save without sending"
    Then I see "Note to suppliers is required" is visible

  @Negative
  Scenario: Create a new RFQ with a line added and a supplier selected with a note to suppliers exceeding 255 characters
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 12345" in "Wings REQ" field
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by" field
    And I enter "Aircraft X" in "Aircraft" field
    And I enter "This is a very long note to suppliers that exceeds the 255 character limit. It should not be allowed to be saved." in "Note to suppliers" field
    And I click on "Add a line"
    And I enter "Part Number 123" in "Part Number" field
    And I enter "Description 123" in "Description" field
    And I enter "10" in "Quantity" field
    And I enter "Unit" in "Unit" field
    And I click on "Add a supplier"
    And I enter "supplier@example.com" in "Supplier Email" field
    And I click on "Save without sending"
    Then I see "Error: Note to suppliers exceeds 255 characters" is visible

