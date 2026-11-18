Feature: Web Automation with Behave

  @Positive @ValidInputs @HappyPath
  Scenario: Create a new RFQ with valid inputs
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" in "Title"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Boeing 737" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York JFK" in "named place"
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

  @Negative @EmptyTitle @InvalidInput
  Scenario: Create a new RFQ with an empty title
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" in "Title"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Boeing 737" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York JFK" in "named place"
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
    Then I see "Title is required" is visible

  @Negative @TitleExceeds8Words @InvalidInput
  Scenario: Create a new RFQ with a title exceeding 8 words
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "This is a title that exceeds eight words" in "Title"
    And I click on "Save without sending"
    Then I see "Title must be 8 words or less" is visible

  @Positive @Title8Words @ValidInput
  Scenario: Create a new RFQ with a title of 8 words
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "This is a title of 8 words" in "Title"
    And I click on "Save without sending"
    Then I do not see "Title must be 8 words or less" is visible
    And I see "RFQ created successfully" is visible

  @Positive @PriorityAOG @ValidInput
  Scenario: Create a new RFQ with a priority set to AOG
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" in "Title"
    And I enter "RQ-12345" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "AW139" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "Supplier Dock" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "NE"
    And I click on "Add a line"
    And I enter "123456" in "Part number"
    And I enter "Description" in "Description"
    And I enter "10" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@supplier.com" in "Email"
    And I enter "Internal note" in "Internal note"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Positive @PriorityAOGRisk @ValidInput
  Scenario: Create a new RFQ with a priority set to AOG risk
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" in "Title"
    And I enter "RQ-12345" in "Wings REQ"
    And I select "AOG risk" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "AW139" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "Supplier Dock" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "NE"
    And I click on "Add a line"
    And I enter "123456" in "Part number"
    And I enter "Description" in "Description"
    And I enter "10" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@supplier.com" in "Email"
    And I enter "Internal note" in "Internal note"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Positive @PriorityCritical @ValidInput
  Scenario: Create a new RFQ with a priority set to Critical
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" in "Title"
    And I select "Critical" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Positive @PriorityRoutine @ValidInput
  Scenario: Create a new RFQ with a priority set to Routine
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" in "Title"
    And I select "Routine" as "Priority"
    And I enter "2024-01-31" in "Answer by"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Negative @InvalidPriority @InvalidInput
  Scenario: Create a new RFQ with an invalid priority
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "InvalidPriority" in "Priority *"
    And I click on "Save without sending"
    Then I see "Invalid priority" is selected as "Priority *"

  @Positive @ValidAircraft @ValidInput
  Scenario: Create a new RFQ with a valid aircraft
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "ValidAircraft" in "Aircraft"
    And I click on "Save without sending"
    Then I see "ValidAircraft" in "Aircraft" Values

  @Negative @InvalidAircraft @InvalidInput
  Scenario: Create a new RFQ with an invalid aircraft
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "InvalidAircraftModel" in "Aircraft"
    And I click on "Save without sending"
    Then I see "Invalid aircraft model" is selected as "Aircraft"

  @Positive @ValidNoteToSuppliers @ValidInput
  Scenario: Create a new RFQ with a valid note to suppliers
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Valid Note" in "Note to suppliers"
    And I click on "Save without sending"
    Then I see "Valid Note" in "Note to suppliers" Values

  @Negative @InvalidNoteToSuppliers @InvalidInput
  Scenario: Create a new RFQ with an invalid note to suppliers
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Invalid note" in "Note to suppliers"
    And I click on "Save without sending"
    Then I see "Invalid note" is "invalid" as "Note to suppliers"

  @Positive @ValidDeliveryTerms @ValidInput
  Scenario: Create a new RFQ with a valid delivery terms
    Given I open "http://localhost:3131/rfqs/new"
    When I select "EXW" as "Delivery terms"
    And I enter "New York" in "named place"
    And I click on "Save without sending"
    Then I see "EXW" is selected as "Delivery terms"
    And I see "New York" in "Delivery terms" Values

  @Negative @InvalidDeliveryTerms @InvalidInput
  Scenario: Create a new RFQ with an invalid delivery terms
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "InvalidIncoterm" in "Delivery terms"
    And I click on "Save without sending"
    Then I see "Invalid delivery terms" is selected as "Delivery terms"

  @Positive @ValidOutrightPurchase @ValidInput
  Scenario: Create a new RFQ with a valid outright purchase
    Given I open "http://localhost:3131/rfqs/new"
    When I select "Outright purchase" as "Outright purchase"
    And I click on "Save without sending"
    Then I see "Outright purchase" is selected as "Outright purchase"

  @Negative @InvalidOutrightPurchase @InvalidInput
  Scenario: Create a new RFQ with an invalid outright purchase
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Invalid Outright Purchase" in "Outright purchase"
    And I click on "Save without sending"
    Then I see "Invalid outright purchase" is selected as "Outright purchase"
    And I see an error message is visible

  @Positive @ValidLineInputs @ValidInput
  Scenario: Add a line with valid inputs
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "Valid Part Number" in "Part number"
    And I enter "Valid Description" in "Description"
    And I enter "1" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Save without sending"
    Then I see "Valid Part Number" in "Part number" Values
    And I see "Valid Description" in "Description" Values
    And I see "1" in "Quantity" Values
    And I see "Unit" in "Unit" Values

  @Negative @InvalidPartNumber @InvalidInput
  Scenario: Add a line with an invalid part number
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "invalid_part_number" in "Part Number"
    And I click on "Save without sending"
    Then I see "Invalid part number" is selected as "Error"

  @Negative @EmptyPartNumber @InvalidInput
  Scenario: Add a line with an empty part number
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I click on "Save without sending"
    Then I see "Part Number" is selected as "Error"

  @Positive @ValidPartNumberAndDescription @ValidInput
  Scenario: Add a line with a valid part number and description
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "123456" in "Part Number"
    And I enter "Valid Description" in "Description"
    And I click on "Save without sending"
    Then I see "Line added successfully" is visible

  @Positive @ValidQuantity @ValidInput
  Scenario: Add a line with a valid quantity
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "123456" in "Part Number"
    And I enter "Valid Description" in "Description"
    And I enter "10" in "Quantity"
    And I click on "Save without sending"
    Then I see "Line added successfully" is visible

  @Negative @InvalidQuantity @InvalidInput
  Scenario: Add a line with an invalid quantity
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "-1" in "Quantity"
    And I click on "Save without sending"
    Then I see "Invalid quantity" is visible

  @Positive @ValidUnit @ValidInput
  Scenario: Add a line with a valid unit
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "10" in "Quantity"
    And I select "Each" as "Unit"
    And I click on "Save without sending"
    Then I see "Line added successfully" is visible

  @Negative @InvalidUnit @InvalidInput
  Scenario: Add a line with an invalid unit
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "10" in "Quantity"
    And I enter "InvalidUnit" in "Unit"
    And I click on "Save without sending"
    Then I see "Invalid unit" is selected as "Unit"

