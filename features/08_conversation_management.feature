Feature: Web Automation with Behave

  @happy_path @required_fields
  Scenario: Happy Path: Create a new RFQ with all required fields
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ-123" as Wings REQ field
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by field
    And I enter "A380" as Aircraft field
    And I enter "Shipping to another base" as Note to suppliers field
    And I select "EXW" as Delivery terms
    And I enter "New York JFK" as named place field
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "Part123" as Part number field
    And I enter "Description1" as Description field
    And I enter "10" as Quantity field
    And I enter "Unit" as Unit field
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as Email field
    And I click on "Save without sending"
    Then I see "RFQ created successfully" message is visible

  @happy_path @add_line_supplier
  Scenario: Happy Path: Add a line and a supplier to the RFQ
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "Part123" as Part number field
    And I enter "Description1" as Description field
    And I enter "10" as Quantity field
    And I enter "Unit" as Unit field
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as Email field
    And I click on "Save without sending"
    Then I see "Line added successfully" message is visible
    And I see "Supplier added successfully" message is visible

  @happy_path @send_rfq
  Scenario: Happy Path: Send the RFQ to suppliers
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" as Title
    And I enter "WINGS-1234" as Wings REQ field
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by field
    And I enter "Boeing 737" as Aircraft field
    And I enter "Shipping to another base" as Note to suppliers field
    And I select "EXW" as Delivery terms
    And I enter "New York" as named place field
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "123456" as Part number field
    And I enter "Engine" as Description field
    And I enter "10" as Quantity field
    And I enter "Unit" as Unit field
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as Email field
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @happy_path @supplier_response
  Scenario: Happy Path: Suppliers respond to the RFQ
    Given I open "http://localhost:3131/rfqs"
    When I click on the RFQ with title "AW139 C-check parts"
    And I click on "Respond"
    And I enter "1000" as Price
    And I enter "2023-12-30" as Delivery date
    And I click on "Submit"
    Then I see "Quote submitted successfully" is visible

  @happy_path @reminders_messages
  Scenario: Happy Path: Supplier sends reminders and messages
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by field
    And I enter "A380" as Aircraft field
    And I enter "Shipping to another base" as Note to suppliers field
    And I select "EXW" as Delivery terms
    And I enter "New York" as named place field
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "Part123" as Part Number field
    And I enter "Description123" as Description field
    And I enter "10" as Quantity field
    And I enter "Unit" as Unit field
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as Email field
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @happy_path @unanswered_questions
  Scenario: Happy Path: Supplier sends unanswered questions
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by field
    And I enter "A380" as Aircraft field
    And I enter "Shipping to another base" as Note to suppliers field
    And I select "EXW" as Delivery terms
    And I enter "New York" as named place field
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "Part123" as Part Number field
    And I enter "Description123" as Description field
    And I enter "10" as Quantity field
    And I enter "Unit" as Unit field
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as Email field
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @happy_path @unanswered_questions_options
  Scenario: Happy Path: Supplier sends unanswered questions with options
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I enter "AOG" as Priority
    And I enter "2023-12-31" as Answer by field
    And I click on "Add a line"
    And I enter "Part123" as Part Number field
    And I enter "Description1" as Description field
    And I enter "10" as Quantity field
    And I enter "Unit1" as Unit field
    And I click on "Add a supplier"
    And I enter "supplier@example.com" as Email field
    And I click on "Save without sending"
    Then I see "Unanswered Questions" is "Pending"
    And I see "Options" is "Available"

  @negative @empty_title
  Scenario: Negative: Empty title field
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "Part123" as Part Number field
    And I enter "Description1" as Description field
    And I enter "10" as Quantity field
    And I enter "Unit1" as Unit field
    And I click on "Add a supplier"
    And I enter "supplier@example.com" as Email field
    And I click on "Save without sending"
    Then I see an error message is visible

  @negative @invalid_priority
  Scenario: Negative: Invalid priority selection
    Given I open "http://localhost:3131/rfqs/new"
    When I select "Invalid Priority" as Priority
    Then I see "Invalid priority selection" is "Error"

  @negative @empty_aircraft
  Scenario: Negative: Empty aircraft field
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" as Aircraft field
    Then I see "Empty aircraft field" is "Error"

  @negative @empty_note_to_suppliers
  Scenario: Negative: Empty note to suppliers field
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" as Note to suppliers field
    And I click on "Save without sending"
    Then I see "Note to suppliers is required" is visible

  @negative @invalid_incoterm
  Scenario: Negative: Invalid Incoterm selection
    Given I open "http://localhost:3131/rfqs/new"
    When I select "InvalidIncoterm" as Delivery terms
    And I click on "Save without sending"
    Then I see "Invalid Incoterm selected" is visible

  @negative @empty_line_part_number
  Scenario: Negative: Empty line part number
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "Part123" as Part Number field
    And I enter "Description1" as Description field
    And I enter "10" as Quantity field
    And I enter "Unit1" as Unit field
    And I click on "Add a supplier"
    And I enter "supplier@example.com" as Email field
    And I click on "Save without sending"
    Then I see an error message is visible

  @negative @empty_line_description
  Scenario: Negative: Empty line description
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "Part123" as Part Number field
    And I enter "" as Description field
    And I enter "10" as Quantity field
    And I enter "Unit1" as Unit field
    And I click on "Add a supplier"
    And I enter "supplier@example.com" as Email field
    And I click on "Save without sending"
    Then I see an error message is visible

  @negative @empty_line_quantity
  Scenario: Negative: Empty line quantity
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "Part123" as Part Number field
    And I enter "Description1" as Description field
    And I enter "" as Quantity field
    And I enter "Unit1" as Unit field
    And I click on "Add a supplier"
    And I enter "supplier@example.com" as Email field
    And I click on "Save without sending"
    Then I see an error message is visible

  @negative @empty_line_unit
  Scenario: Negative: Empty line unit
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "Part123" as Part Number field
    And I enter "Description1" as Description field
    And I enter "10" as Quantity field
    And I enter "" as Unit field
    And I click on "Add a supplier"
    And I enter "supplier@example.com" as Email field
    And I click on "Save without sending"
    Then I see an error message is visible

  @negative @empty_supplier_email
  Scenario: Negative: Empty supplier email
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "Part123" as Part Number field
    And I enter "Description1" as Description field
    And I enter "10" as Quantity field
    And I enter "Unit1" as Unit field
    And I click on "Add a supplier"
    And I enter "" as Email field
    And I click on "Save without sending"
    Then I see an error message is visible

  @negative @invalid_supplier_email
  Scenario: Negative: Invalid supplier email
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "Part123" as Part Number field
    And I enter "Description1" as Description field
    And I enter "10" as Quantity field
    And I enter "Unit1" as Unit field
    And I click on "Add a supplier"
    And I enter "invalidemail" as Email field
    And I click on "Save without sending"
    Then I see an error message is visible

  @negative @empty_rfq_save
  Scenario: Negative: Empty RFQ save
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Save without sending"
    Then I see an error message is visible

  @negative @invalid_rfq_save
  Scenario: Negative: Invalid RFQ save
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" as Title
    And I enter "WINGS-1234" as Wings REQ field
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by field
    And I enter "Boeing 737" as Aircraft field
    And I enter "Shipping to another base" as Note to suppliers field
    And I select "EXW" as Delivery terms
    And I enter "New York" as named place field
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "123456" as Part number field
    And I enter "Engine" as Description field
    And I enter "10" as Quantity field
    And I enter "Unit" as Unit field
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as Email field
    And I click on "Save without sending"
    Then I see an error message is visible

  @negative @empty_response_save
  Scenario: Negative: Empty response save
    Given I open "http://localhost:3131/rfqs"
    When I click on the RFQ with title "AW139 C-check parts"
    And I click on "Respond"
    And I enter "1000" as Price
    And I enter "2023-12-30" as Delivery date
    And I click on "Submit"
    Then I see an error message is visible

  @negative @invalid_response_save
  Scenario: Negative: Invalid response save
    Given I open "http://localhost:3131/rfqs"
    When I click on the RFQ with title "AW139 C-check parts"
    And I click on "Respond"
    And I enter "1000" as Price
    And I enter "2023-12-30" as Delivery date
    And I click on "Submit"
    Then I see an error message is visible

  @negative @empty_unanswered_questions
  Scenario: Negative: Empty unanswered questions
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by field
    And I enter "A380" as Aircraft field
    And I enter "Shipping to another base" as Note to suppliers field
    And I select "EXW" as Delivery terms
    And I enter "New York" as named place field
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "Part123" as Part Number field
    And I enter "Description123" as Description field
    And I enter "10" as Quantity field
    And I enter "Unit" as Unit field
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as Email field
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @negative @empty_unanswered_questions_options
  Scenario: Negative: Empty unanswered questions options
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" as Title
    And I select "AOG" as Priority
    And I enter "2023-12-31" as Answer by field
    And I enter "A380" as Aircraft field
    And I enter "Shipping to another base" as Note to suppliers field
    And I select "EXW" as Delivery terms
    And I enter "New York" as named place field
    And I select "Outright purchase" as Outright purchase/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "Part123" as Part Number field
    And I enter "Description123" as Description field
    And I enter "10" as Quantity field
    And I enter "Unit" as Unit field
    And I click on "Add a supplier"
    And I enter "supplier@company.com" as Email field
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @negative @empty_unanswered_questions_response
  Scenario: Negative: Empty unanswered questions response
    Given I open "http://localhost:3131/rfqs"
    When I click on the RFQ with title "AW139 C-check parts"
    And I click on "Respond"
    And I enter "1000" as Price
    And I enter "2023-12-30" as Delivery date
    And I click on "Submit"
    Then I see an error message is visible

  @negative @invalid_unanswered_questions_response
  Scenario: Negative: Invalid unanswered questions response
    Given I open "http://localhost:3131/rfqs"
    When I click on the RFQ with title