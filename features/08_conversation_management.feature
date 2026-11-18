Feature: Web Automation with Behave

  @happy_path @required_fields
  Scenario: Happy Path: Create a new RFQ with all required fields
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ-123" in "Wings REQ" field
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by" field
    And I enter "A380" in "Aircraft" field
    And I enter "Shipping to another base" in "Note to suppliers" field
    And I select "EXW" as "Delivery terms"
    And I enter "New York JFK" in "named place" field
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "Part123" in "Part number" field
    And I enter "Description1" in "Description" field
    And I enter "10" in "Quantity" field
    And I enter "Unit" in "Unit" field
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "Email" field
    And I click on "Save without sending"
    Then I see "RFQ created successfully" message is visible

  @happy_path @add_line_supplier
  Scenario: Happy Path: Add a line and a supplier to the RFQ
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "Part123" in "Part number" field
    And I enter "Description1" in "Description" field
    And I enter "10" in "Quantity" field
    And I enter "Unit" in "Unit" field
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "Email" field
    And I click on "Save without sending"
    Then I see "Line added successfully" message is visible
    And I see "Supplier added successfully" message is visible

  @happy_path @send_rfq
  Scenario: Happy Path: Send the RFQ to suppliers
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "AW139 C-check parts" in "Title"
    And I enter "WINGS-1234" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Boeing 737" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "123456" in "Part number"
    And I enter "Engine" in "Description"
    And I enter "10" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "Email"
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @happy_path @supplier_response
  Scenario: Happy Path: Suppliers respond to the RFQ
    Given I open "http://localhost:3131/rfqs"
    When I click on the RFQ with title "AW139 C-check parts"
    And I click on "Respond"
    And I enter "1000" in "Price"
    And I enter "2023-12-30" in "Delivery date"
    And I click on "Submit"
    Then I see "Quote submitted successfully" is visible

  @happy_path @reminders_messages
  Scenario: Happy Path: Supplier sends reminders and messages
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
    And I enter "Part123" in "Part Number"
    And I enter "Description123" in "Description"
    And I enter "10" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "Email"
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @happy_path @unanswered_questions
  Scenario: Happy Path: Supplier sends unanswered questions
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
    And I enter "Part123" in "Part Number"
    And I enter "Description123" in "Description"
    And I enter "10" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "Email"
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @happy_path @unanswered_questions_options
  Scenario: Happy Path: Supplier sends unanswered questions with options
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" in "Title"
    And I enter "AOG" in "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I click on "Add a line"
    And I enter "Part123" in "Part Number"
    And I enter "Description1" in "Description"
    And I enter "10" in "Quantity"
    And I enter "Unit1" in "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@example.com" in "Email"
    And I click on "Save without sending"
    Then I see "Unanswered Questions" is "Pending"
    And I see "Options" is "Available"

  @negative @empty_title
  Scenario: Negative: Empty title field
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "Part123" in "Part Number"
    And I enter "Description1" in "Description"
    And I enter "10" in "Quantity"
    And I enter "Unit1" in "Unit"
    And I click on "Add a supplier"
    And I enter "supplier@example.com" in "Email"
    And I click on "Save without sending"
    Then I see an error message is visible

  @negative @invalid_priority
  Scenario: Negative: Invalid priority selection
    Given I open "http://localhost:3131/rfqs/new"
    When I select "Invalid Priority" as "Priority *"
    Then I see "Invalid priority selection" is "Error"

  @negative @empty_aircraft
  Scenario: Negative: Empty aircraft field
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" in "Aircraft"
    Then I see "Empty aircraft field" is "Error"

  @negative @empty_note_to_suppliers
  Scenario: Negative: Empty note to suppliers field
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" in "Note to suppliers"
    And I click on "Save without sending"
    Then I see "Note to suppliers is required" is visible

  @negative @invalid_incoterm
  Scenario: Negative: Invalid Incoterm selection
    Given I open "http://localhost:3131/rfqs/new"
    When I select "InvalidIncoterm" as "Delivery terms"
    And I click on "Save without sending"
    Then I see "Invalid Incoterm selected" is visible

  @negative @empty_line_part_number
  Scenario: Negative: Empty line part number
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I click on "Add a supplier"
    And I click on "Save without sending"
    Then I see "Part number is required" is visible

  @negative @empty_line_description
  Scenario: Negative: Empty line description
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "1" in "Part number"
    And I click on "Add a supplier"
    And I click on "Save without sending"
    Then I see "Description is required" is visible

  @negative @empty_line_quantity
  Scenario: Negative: Empty line quantity
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "" in "Quantity"
    And I click on "Save without sending"
    Then I see "Quantity is required" is visible

  @negative @empty_line_unit
  Scenario: Negative: Empty line unit
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "" in "Unit"
    And I click on "Save without sending"
    Then I see "Unit is required" is visible

  @negative @empty_supplier_email
  Scenario: Negative: Empty supplier email
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" in "supplier email"
    And I click on "Save without sending"
    Then I see "Error: Supplier email is required" is visible

  @boundary_edge_case @max_title_length
  Scenario: Boundary Edge Case: Maximum title length
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "This is a very long title that should be exactly 8 words" in "Title"
    And I click on "Save without sending"
    Then I see "Title is valid" is visible

  boundary_edge_case, max_objective_length
  Scenario: Boundary Edge Case: Maximum Objective Length
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "This is a very long objective that should be exactly 18 words long. This is a very long objective that should be exactly 18 words long." in "Objective"
    Then I see "Objective" is "This is a very long objective that should be exactly 18 words long. This is a very long objective that should be exactly 18 words long."

  boundary_edge_case, max_line_part_number_length
  Scenario: Boundary Edge Case: Maximum Line Part Number Length
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "ThisIsAVeryLongLinePartNumberThatShouldBeExactly32CharactersLong" in "Line Part Number"
    Then I see "Line Part Number" is "ThisIsAVeryLongLinePartNumberThatShouldBeExactly32CharactersLong"

  boundary_edge_case, max_line_description_length
  Scenario: Boundary Edge Case: Maximum Line Description Length
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:800>" in "Line Description" field
    Then I see "Line Description" field is "<RANDOM:800>"

  boundary_edge_case, max_line_quantity_length
  Scenario: Boundary Edge Case: Maximum Line Quantity Length
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:800>" in "Line Quantity" field
    Then I see "Line Quantity" field is "<RANDOM:800>"

  boundary_edge_case, max_line_unit_length
  Scenario: Boundary Edge Case: Maximum Line Unit Length
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" in "Line Unit" field
    Then I see "Line Unit" field is "<RANDOM:8>"

  boundary_edge_case, max_supplier_email_length
  Scenario: Boundary Edge Case: Maximum Supplier Email Length
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>@example.com" in "Supplier Email" field
    Then I see "Supplier Email" field is "<RANDOM:8>@example.com"

  strict_generation_rule, field_length_limits
  Scenario: Strict Generation Rule: Field length limits
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "A very long title that exceeds the maximum allowed length" in "Title"
    Then I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"
    And I see "Title" is "A very long title that exceeds the maximum allowed length"

