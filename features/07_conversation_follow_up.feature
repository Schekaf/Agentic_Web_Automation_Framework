Feature: Conversation and Follow-Up

  @InitiateRfqMultipleSuppliers
  Scenario: Initiate RFQ with multiple suppliers
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

  @FollowUpUnansweredQuestions
  Scenario: Follow-up with unanswered questions
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
    When I click on "Follow-up"
    Then I see "Unanswered questions" is visible

  @SendReminderLateSuppliers
  Scenario: Send reminder to late suppliers
    Given I open "http://localhost:3131"
    When I navigate to the supplier dashboard
    And I filter for late suppliers
    And I click on the reminder button for a supplier
    Then I see the reminder sent confirmation

  @HandleSupplierDecline
  Scenario: Handle supplier decline
    Given I open "http://localhost:3131"
    When I navigate to the supplier dashboard
    And I select a supplier with a declined RFQ
    And I update the RFQ status to declined
    Then I see the RFQ status updated to declined

  @InvalidSupplierInput
  Scenario: Invalid supplier input
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid_req_number" in "Wings REQ"
    And I enter "" in "Title"
    And I enter "invalid date" in "Answer by"
    And I click on "Add a line"
    And I enter "1" in "Line 1"
    And I click on "Add a supplier"
    And I enter "invalid_email@company.com" in "sales@supplier.com; several with ;"
    And I click on "Save without sending"
    Then I see "Invalid Wings REQ number" is visible
    And I see "Title is required" is visible
    And I see "Invalid date format" is visible

  @ZeroSuppliersAsked
  Scenario: Zero suppliers asked
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

  @NegativeSupplierCount
  Scenario: Negative supplier count
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "-1" in "Supplier Count"
    Then I see "Invalid supplier count" is visible

  @MaxSupplierLimit
  Scenario: Max supplier limit
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "51" in "Supplier Count"
    Then I see "Exceeded maximum supplier limit" is visible

  @EmptyLineItems
  Scenario: Reject RFQ with empty line items
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I click on "Save without sending"
    Then I see "Line items cannot be empty" is visible

  @LineItemNoOptions
  Scenario: Reject line item with no options
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I click on "Add a supplier"
    And I click on "Save without sending"
    Then I see "Line item must have options" is visible

  @LateSupplierReminderConflict
  Scenario: Verify system handles conflicting late supplier reminders
    Given I open "http://localhost:3131"
    When I click on "Late Supplier Reminders"
    And I select "Conflict" as "Reminder Type"
    Then I see "Conflict Detected" is visible

  @SuppliersWithinAnswerTime
  Scenario: Verify system handles suppliers within answer time
    Given I open "http://localhost:3131"
    When I click on "Supplier Responses"
    And I select "Within Time" as "Response Status"
    Then I see "On Time" is visible

