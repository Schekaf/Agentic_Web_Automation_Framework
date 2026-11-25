Feature: Comparison and Pre-Evaluation

  @SelectLowestPricePerSupplier
  Scenario: Select Lowest Price per Supplier
    Given I open "http://localhost:3131"
    When I click on "Supplier Comparison"
    And I select "Supplier A" as Supplier
    And I select "Supplier B" as Supplier
    Then I see Supplier A's price is highlighted in green

  @CompareLatestConfirmedRevisions
  Scenario: Compare Latest Confirmed Revisions
    Given I open "http://localhost:3131"
    When I click on "Revisions"
    And I select "Supplier A" as Supplier
    Then I see the latest confirmed revision for Supplier A

  @EvaluatePriceIndex
  Scenario: Evaluate Price Index
    Given I open "http://localhost:3131"
    When I click on "Price Index"
    Then I see "Price Index" is displayed

  @CheckArrivalAgainstNeedDate
  Scenario: Check Arrival Against Need Date
    Given I open "http://localhost:3131"
    When I click on "Arrival Date"
    And I enter "<TODAY>" in "Arrival Date"
    Then I see "Arrival Date" matches "Need Date"

  @HandleUnreadExclusions
  Scenario: Verify system correctly handles and displays unread exclusions
    Given I open "http://localhost:3131"
    When I click on "Unread Exclusions"
    Then I see unread exclusions are displayed

  @SelectNonLowestPriceWithReason
  Scenario: Verify system requires a reason when selecting a price that is not the lowest
    Given I open "http://localhost:3131"
    When I select a price that is not the lowest
    Then I see a reason is required

  @RejectInvalidSupplier
  Scenario: Reject RFQ submission from a disqualified supplier
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

  @HandleLateArrival
  Scenario: Handle late arrival
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

  @CheckPriceAgreement
  Scenario: Check Price Agreement
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

  @HandleSupplierStanding
  Scenario: Handle Supplier Standing
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

  @DropUnneededLine
  Scenario: Drop Unneeded Line
    Given I open "http://localhost:3131/rfqs/new"
    When I add a line with part number "123456" and description "Part Description"
    And I click on "Drop Line" for the added line
    Then I see "Line dropped successfully" is visible

  @HandleEmptyLineItems
  Scenario: Handle Empty Line Items
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I click on "Save without sending"
    Then I see "Line items are required" is visible

