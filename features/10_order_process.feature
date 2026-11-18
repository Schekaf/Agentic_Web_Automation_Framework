Feature: Web Automation with Behave

  @Positive
  Scenario: Create a new RFQ with valid data
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "A380" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "New York" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "Part123" as Part number
    And I enter "Description1" as Description
    And I enter "10" as Quantity
    And I enter "Unit1" as Unit
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as Email
    And I enter "Internal note for the team" as Internal note
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @Negative
  Scenario: Create a new RFQ with an empty title
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" as Title
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "A380" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "New York" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "Part123" as Part number
    And I enter "Description1" as Description
    And I enter "10" as Quantity
    And I enter "Unit1" as Unit
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as Email
    And I enter "Internal note for the team" as Internal note
    And I click on "Save without sending"
    Then I see "Title is required" is visible

  @Negative
  Scenario: Create a new RFQ with a title exceeding 8 words
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "This is a very long title that exceeds eight words" as Title
    And I click on "Save without sending"
    Then I see "Title must be 8 words or less" is visible

  @Positive
  Scenario: Create a new RFQ with a title of 8 words
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "This is a title of exactly eight words" as Title
    And I click on "Save without sending"
    Then I do not see "Title must be 8 words or less" is visible

  @Positive
  Scenario: Create a new RFQ with a valid Wings REQ
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" as Title
    And I enter "RQ-12345" as Wings REQ
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "AW139" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "New York" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "Part123" as Part number
    And I enter "Description1" as Description
    And I enter "10" as Quantity
    And I enter "Unit1" as Unit
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as Email
    And I enter "Internal note for the team" as Internal note
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Negative
  Scenario: Create a new RFQ with an invalid Wings REQ
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" as Title
    And I enter "InvalidREQ" as Wings REQ
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "AW139" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "New York" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "Part123" as Part number
    And I enter "Description1" as Description
    And I enter "10" as Quantity
    And I enter "Unit1" as Unit
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as Email
    And I enter "Internal note for the team" as Internal note
    And I click on "Save without sending"
    Then I see "Invalid Wings REQ" is visible

  @Positive
  Scenario: Create a new RFQ with a valid priority
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Negative
  Scenario: Create a new RFQ with an invalid priority
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I select "Invalid Priority" as Priority
    And I enter "2023-12-31" as Answer by
    And I click on "Save without sending"
    Then I see "Invalid priority selected" is visible

  @Positive
  Scenario: Create a new RFQ with a valid answer by date
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" as Title
    And I enter "RQ-1234" as Wings REQ
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I click on "Add a line"
    And I enter "Part123" as Part Number
    And I enter "Description1" as Description
    And I enter "10" as Quantity
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @Negative
  Scenario: Create a new RFQ with an invalid answer by date
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" as Title
    And I enter "RQ-1234" as Wings REQ
    And I select "AOG" as Priority
    And I enter "2022-12-31" as Answer by
    And I click on "Add a line"
    And I enter "Part123" as Part Number
    And I enter "Description1" as Description
    And I enter "10" as Quantity
    And I click on "Save without sending"
    Then I see "Invalid answer by date" is visible

  @Positive
  Scenario: Create a new RFQ with a valid aircraft
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I enter "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "A320" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "New York" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "Part123" as Part Number
    And I enter "Description1" as Description
    And I enter "10" as Quantity
    And I enter "Unit1" as Unit
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as Email
    And I enter "Internal note for RFQ" as Internal note
    Then I see "Save without sending" is visible

  @Negative
  Scenario: Create a new RFQ with an invalid aircraft
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I enter "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "Invalid Aircraft" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "New York" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "Part123" as Part Number
    And I enter "Description1" as Description
    And I enter "10" as Quantity
    And I enter "Unit1" as Unit
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as Email
    And I enter "Internal note for RFQ" as Internal note
    And I click on "Save without sending"
    Then I see "Invalid aircraft error message" is visible

  @Positive
  Scenario: Create a new RFQ with a valid internal note
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I enter "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "A320" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "New York" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "Part123" as Part Number
    And I enter "Description1" as Description
    And I enter "10" as Quantity
    And I enter "Unit1" as Unit
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as Email
    And I enter "Internal note for RFQ" as Internal note
    Then I see "Save without sending" is visible

  @Negative
  Scenario: Create a new RFQ with an invalid internal note
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I enter "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "A320" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "New York" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "Part123" as Part Number
    And I enter "Description1" as Description
    And I enter "10" as Quantity
    And I enter "Unit1" as Unit
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as Email
    And I enter "Invalid Internal Note" as Internal note
    And I click on "Save without sending"
    Then I see "Invalid internal note error message" is visible

  @Positive
  Scenario: Create a new RFQ with a valid incoterm
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I enter "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "A320" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "New York" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "Part123" as Part Number
    And I enter "Description1" as Description
    And I enter "10" as Quantity
    And I enter "Unit1" as Unit
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as Email
    And I enter "Internal note for RFQ" as Internal note
    Then I see "Save without sending" is visible

  @Negative
  Scenario: Create a new RFQ with an invalid incoterm
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I enter "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "A320" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "Invalid Incoterm" as Delivery terms
    And I enter "New York" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "Part123" as Part Number
    And I enter "Description1" as Description
    And I enter "10" as Quantity
    And I enter "Unit1" as Unit
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as Email
    And I enter "Internal note for RFQ" as Internal note
    And I click on "Save without sending"
    Then I see "Invalid incoterm" is visible

  @Positive
  Scenario: Create a new RFQ with a valid incoterm place
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I enter "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "A320" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "New York" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "Part123" as Part Number
    And I enter "Description1" as Description
    And I enter "10" as Quantity
    And I enter "Unit1" as Unit
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as Email
    And I enter "Internal note for RFQ" as Internal note
    Then I see "Save without sending" is visible

  @Negative
  Scenario: Create a new RFQ with an invalid incoterm place
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I enter "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "A320" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "Invalid Incoterm Place" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "Part123" as Part Number
    And I enter "Description1" as Description
    And I enter "10" as Quantity
    And I enter "Unit1" as Unit
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as Email
    And I enter "Internal note for RFQ" as Internal note
    And I click on "Save without sending"
    Then I see "Invalid incoterm place" is visible

  @Positive
  Scenario: Create a new RFQ with a valid exchange term
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I enter "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "A320" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select