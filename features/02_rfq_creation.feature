Feature: Web Automation with Behave

  @happy_path
  Scenario: Create a new RFQ with valid inputs
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" as Title
    And I enter "RQ-1234" as Wings REQ
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "Boeing 737" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "New York JFK" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "NE"
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

  @negative
  Scenario: Create a new RFQ with invalid priority selection
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" as Title
    And I enter "RQ-1234" as Wings REQ
    And I select "Invalid Priority" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "Boeing 737" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "New York JFK" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "NE"
    And I click on "Add a line"
    And I enter "123456" as part number
    And I enter "Part Description" as description
    And I enter "10" as quantity
    And I enter "Unit" as unit
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as sales@supplier.com; several with ;
    And I enter "Internal note for the team" as Internal note
    And I click on "Save without sending"
    Then I see "Invalid priority selection" is visible

  @NewRFQCreation
  Scenario: Create a new RFQ with empty title
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" as Title
    And I click on "Save without sending"
    Then I see "Title is required" is visible

  @NewRFQCreation
  Scenario: Create a new RFQ with invalid Wings REQ number
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid_req_number" as Wings REQ
    And I click on "Save without sending"
    Then I see "Invalid Wings REQ number" is visible

  @negative
  Scenario: Create a new RFQ with invalid Incoterm selection
    Given I open "http://localhost:3131/rfqs/new"
    When I select "Invalid Incoterm" as Delivery terms
    And I click on "Save without sending"
    Then I see "Invalid Incoterm" is selected as Delivery terms
    And I see an error message indicating invalid Incoterm selection

  @negative
  Scenario: Create a new RFQ with empty part number
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" as Part Number
    And I click on "Save without sending"
    Then I see an error message indicating empty part number

  @NewRFQCreation
  Scenario: Create a new RFQ with empty description
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" as Title
    And I click on "Save without sending"
    Then I see "Title is required" is visible

  @NewRFQCreation
  Scenario: Create a new RFQ with invalid quantity
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "100" as Quantity
    And I click on "Save without sending"
    Then I see "Invalid quantity" is visible

  @negative
  Scenario: Create a new RFQ with invalid unit
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid_unit" as Unit
    And I click on "Save without sending"
    Then I see "Invalid unit" is selected as Unit

  @negative
  Scenario: Create a new RFQ with empty supplier name
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" as Supplier Name
    And I click on "Save without sending"
    Then I see "Supplier Name" is empty

  @NewRFQCreation
  Scenario: Create a new RFQ with empty supplier address
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" as Supplier Address
    And I click on "Save without sending"
    Then I see "Supplier Address is required" is visible

  @NewRFQCreation
  Scenario: Create a new RFQ with invalid supplier name
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "InvalidName" as Supplier Name
    And I click on "Save without sending"
    Then I see "Invalid supplier name" is visible

  @negative
  Scenario: Create a new RFQ with invalid supplier address
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Invalid Address" as Supplier Address
    And I click on "Save without sending"
    Then I see "Invalid address format" is displayed

  @negative
  Scenario: Create a new RFQ with empty note to suppliers
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" as Note to suppliers
    And I click on "Save without sending"
    Then I see "Note to suppliers is required" is visible

  @negative
  Scenario: Create a new RFQ with empty internal note
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" as Internal note
    And I click on "Save without sending"
    Then I see "Internal note is required" is visible

  @negative
  Scenario: Create a new RFQ with invalid date
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid date" as Answer by
    And I click on "NE"
    And I click on "Add a line"
    And I enter "1" as Line 1
    And I click on "Save without sending"
    Then I see "Invalid date format" is visible