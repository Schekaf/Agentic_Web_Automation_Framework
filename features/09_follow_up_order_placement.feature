Feature: Web Automation with Behave

  @Positive
  Scenario: Create a new RFQ with valid inputs
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "A320" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "New York" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "Part123" as Part number
    And I enter "Description1" as Description
    And I enter "10" as Quantity
    And I enter "Unit" as Unit
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as Email
    And I enter "Internal note for the team" as Internal note
    Then I see "Save without sending" is enabled
    And I click on "Save without sending"

  @Negative
  Scenario: Create a new RFQ with an empty title
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" as Title
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "A320" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "New York" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "Part123" as Part number
    And I enter "Description1" as Description
    And I enter "10" as Quantity
    And I enter "Unit" as Unit
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as Email
    And I enter "Internal note for the team" as Internal note
    Then I see "Save without sending" is disabled

  @Negative
  Scenario: Create a new RFQ with a title exceeding 8 words
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "This is a very long title that exceeds eight words" as Title
    And I click on "Save without sending"
    Then I see "Title must be 8 words or less" is visible

  @Positive
  Scenario: Create a new RFQ with a priority set to AOG
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" as Title
    And I select "AOG" as Priority
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Positive
  Scenario: Create a new RFQ with a priority set to AOG risk
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" as Title
    And I select "AOG risk" as Priority
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Positive
  Scenario: Create a new RFQ with a priority set to Critical
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" as Title
    And I select "Critical" as Priority
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Positive
  Scenario: Create a new RFQ with a priority set to Routine
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I select "Routine" as Priority
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Negative
  Scenario: Create a new RFQ with an invalid Incoterm
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I select "Invalid Incoterm" as Delivery terms
    And I click on "Save without sending"
    Then I see "Invalid Incoterm" is selected as Delivery terms
    And I see "Error: Invalid Incoterm" is visible

  @Positive
  Scenario: Create a new RFQ with a valid Incoterm and named place
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "Boeing 737" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "New York" as named place
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Negative
  Scenario: Create a new RFQ with an invalid delivery term
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "Boeing 737" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "Invalid Term" as Delivery terms
    And I click on "Save without sending"
    Then I see "Invalid delivery term" is visible

  @Positive
  Scenario: Create a new RFQ with a valid delivery term and named place
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "A380" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "New York JFK" as named place
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Negative
  Scenario: Create a new RFQ with an empty note to suppliers
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "A380" as Aircraft
    And I leave "Note to suppliers" empty
    And I select "EXW" as Delivery terms
    And I enter "New York JFK" as named place
    And I click on "Save without sending"
    Then I see "Note to suppliers cannot be empty" is visible

  @Positive
  Scenario: Create a new RFQ with a valid note to suppliers
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" as Title
    And I enter "Wings REQ-1234" as Wings REQ
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "Boeing 737" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "Supplier Dock" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "NE"
    And I click on "Add a line"
    And I enter "Part Number 1" as part number
    And I enter "Description 1" as description
    And I enter "10" as quantity
    And I enter "Unit" as unit
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as sales@supplier.com; several with ;
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Negative
  Scenario: Create a new RFQ with an empty internal note
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I enter "AW139 C-check parts" as Wings REQ
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "A380" as Aircraft
    And I enter "" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "Supplier Dock" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "10" as Quantity
    And I enter "Unit" as Unit
    And I enter "Internal note for the team" as Internal note
    Then I see "Save without sending" is enabled

  @Positive
  Scenario: Create a new RFQ with a valid internal note
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" as Title
    And I enter "Wings REQ-1234" as Wings REQ
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "Boeing 737" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "New York" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "10" as Quantity
    And I enter "Unit" as Unit
    And I enter "Internal note for the team" as Internal note
    Then I see "Save without sending" is enabled

  @Positive
  Scenario: Add a line with valid inputs
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "10" as Quantity
    And I enter "Unit" as Unit
    Then I see "Add a line" is disabled

  @Negative
  Scenario: Add a line with an empty part number
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "" as Part Number
    And I click on "Save without sending"
    Then I see "Part number is required" is visible

  @Negative
  Scenario: Add a line with a part number exceeding character limit
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "<RANDOM:100>" as Part Number
    And I click on "Save without sending"
    Then I see "Part number exceeds character limit" is visible

  @Positive
  Scenario: Add a line with a valid part number and description
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "123456" as Part Number
    And I enter "Valid Description" as Description
    And I enter "10" as Quantity
    And I enter "Unit" as Unit
    Then I see "Line added successfully" is visible

  @Negative
  Scenario: Add a line with an empty quantity
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "123456" as Part Number
    And I enter "Valid Description" as Description
    And I enter "" as Quantity
    And I enter "Unit" as Unit
    Then I see "Quantity cannot be empty" is visible

  @Negative
  Scenario: Add a line with a quantity exceeding numerical threshold
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" as Quantity
    Then I see "Quantity exceeds numerical threshold" is visible

  @Positive
  Scenario: Add a line with a valid quantity
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "10" as Quantity
    Then I do not see "Quantity exceeds numerical threshold" is visible

  @Negative
  Scenario: Add a line with an empty unit
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "" as Unit
    And I click on "Save without sending"
    Then I see "Unit is required" is visible

  @Positive
  Scenario: Add a line with a valid unit
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "Each" as Unit
    And I click on "Save without sending"
    Then I do not see "Unit is required" is visible

  @Negative
  Scenario: Add a line with an empty supplier
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I click on "Add a supplier"
    And I enter "" as supplier
    And I click on "Save without sending"
    Then I see "supplier is required" is visible