Feature: Answer Processing and Quotes

  @ProcessValidAnswerMessageID
  Scenario: Process valid answer with matching Message-ID
    Given I open "http://localhost:3131"
    When I enter "valid_answer" in "Answer Text"
    And I enter "matching_message_id" in "Message-ID"
    Then I see "Answer processed successfully" is visible

  @ProcessAnswerChangedSubject
  Scenario: Process answer with changed subject
    Given I open "http://localhost:3131"
    When I enter "valid_answer" in "Answer Text"
    And I enter "new_subject" in "Subject"
    Then I see "Answer processed successfully" is visible

  @ProcessAnswerDifferentSender
  Scenario: Process answer with different sender
    Given I open "http://localhost:3131/answers/new"
    When I enter "AW139 C-check parts" as Title
    And I enter "RQ-1234" as Wings REQ
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "Boeing 737" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "New York JFK" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "123456" as part number
    And I enter "Part Description" as description
    And I enter "10" as quantity
    And I enter "Unit" as unit
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as sales@supplier.com; several with ;
    And I enter "Internal note for the team" as Internal note
    And I click on "Save without sending"
    Then I see "Answer saved successfully" is visible

  @ProcessAnswerInvalidApikey
  Scenario: Process answer with invalid ANTHROPIC_API_KEY
    Given I open "http://localhost:3131/answers/new"
    When I enter "AW139 C-check parts" as Title
    And I enter "RQ-1234" as Wings REQ
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by
    And I enter "Boeing 737" as Aircraft
    And I enter "Shipping to another base" as Note to suppliers
    And I select "EXW" as Delivery terms
    And I enter "New York JFK" as named place
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "123456" as part number
    And I enter "Part Description" as description
    And I enter "10" as quantity
    And I enter "Unit" as unit
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as sales@supplier.com; several with ;
    And I enter "Internal note for the team" as Internal note
    And I click on "Save without sending"
    Then I see "Invalid ANTHROPIC_API_KEY" is visible

  @ProcessAnswerMissingLineItem
  Scenario: Process answer with missing line item
    Given I open "http://localhost:3131/answers/new"
    When I enter "AW139 C-check parts" in "Title"
    And I enter "RQ-1234" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Boeing 737" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York JFK" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Save without sending"
    Then I see "Answer saved successfully" is visible

  @ProcessAnswerInvalidLineItemData
  Scenario: Process answer with invalid line item data
    Given I open "http://localhost:3131/answers/new"
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
    And I enter "invalid_quantity" in "quantity"
    And I enter "Unit" in "unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "sales@supplier.com; several with ;"
    And I enter "Internal note for the team" in "Internal note"
    And I click on "Save without sending"
    Then I see "Invalid quantity format" is visible

  @ProcessAnswerDeclinedLineItem
  Scenario: Process answer with declined line item
    Given I open "http://localhost:3131/answers/new"
    When I enter "AW139 C-check parts" in "Title"
    And I select "Declined" as "Status"
    Then I see "Answer declined" is visible

  @ProcessAnswerPriceMatch
  Scenario: Process answer with price match
    Given I open "http://localhost:3131/answers/new"
    When I enter "AW139 C-check parts" in "Title"
    And I enter "1000" in "Price"
    Then I see "Price match found" is visible

  @ProcessAnswerEmptyLineItems
  Scenario: Process answer with empty line items
    Given I open "http://localhost:3131/answers/new"
    When I click on "Add a line"
    And I click on "Add a line"
    And I click on "Add a line"
    And I click on "Add a line"
    And I click on "Add a line"
    And I click on "Add a line"
    And I click on "Add a line"
    And I click on "Add a line"
    And I click on "Add a line"
    Then I see "Answer cannot be empty" is visible

  @ProcessAnswerMaxLineItems
  Scenario: Process answer with max number of line items
    Given I open "http://localhost:3131/answers/new"
    When I click on "Add a line"
    And I click on "Add a line"
    And I click on "Add a line"
    And I click on "Add a line"
    And I click on "Add a line"
    And I click on "Add a line"
    And I click on "Add a line"
    And I click on "Add a line"
    And I click on "Add a line"
    Then I see "Maximum number of line items reached" is visible

  @ProcessAnswerZeroLineItems
  Scenario: Process answer with zero line items
    Given I open "http://localhost:3131/answers/new"
    When I click on "Add a line"
    And I click on "Remove line"
    Then I see "Answer saved successfully" is visible

  @ProcessAnswerInvalidLineItemType
  Scenario: Process answer with invalid line item type
    Given I open "http://localhost:3131/answers/new"
    When I click on "Add a line"
    And I select "Invalid Type" as Line Item Type
    Then I see "Invalid line item type" is visible

