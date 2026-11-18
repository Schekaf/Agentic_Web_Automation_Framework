Feature: Boundary Edge Cases for RFQ Creation

  @late_core_fee
  Scenario: Boundary Edge Case - Late Core Fee
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" in "Title"
    And I enter "<RANDOM:8>" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "<TODAY>" in "Answer by"
    And I enter "<RANDOM:8>" in "Aircraft"
    And I enter "<RANDOM:8>" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "<RANDOM:8>" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "<RANDOM:8>" in "Part number"
    And I enter "<RANDOM:8>" in "Description"
    And I enter "1" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Add a supplier"
    And I enter "<RANDOM:8>" in "Type to search, or a new name"
    And I enter "sales@supplier.com; several with ;" in "sales@supplier.com; several with ;"
    And I click on "Save without sending"
    Then I see "Success Message" is "Visible"

  @core_ber
  Scenario: Boundary Edge Case - Core BER
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" in "Title"
    And I enter "<RANDOM:8>" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "<TODAY>" in "Answer by"
    And I enter "<RANDOM:8>" in "Aircraft"
    And I enter "<RANDOM:8>" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "<RANDOM:8>" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "<RANDOM:8>" in "Part number"
    And I enter "<RANDOM:8>" in "Description"
    And I enter "1" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Add a supplier"
    And I enter "<RANDOM:8>" in "Supplier name"
    And I enter "sales@supplier.com" in "Email"
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @no_fault_found_fees
  Scenario: Boundary Edge Case - No-Fault Found Fees
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" in "Title"
    And I enter "<RANDOM:8>" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "<TODAY>" in "Answer by"
    And I enter "<RANDOM:8>" in "Aircraft"
    And I enter "<RANDOM:8>" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "<RANDOM:8>" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "<RANDOM:8>" in "Part number"
    And I enter "<RANDOM:8>" in "Description"
    And I enter "1" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Add a supplier"
    And I enter "<RANDOM:8>" in "Supplier name"
    And I enter "sales@supplier.com" in "Email"
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @ber_limit
  Scenario: Boundary Edge Case - BER Limit
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" in "Title"
    And I enter "<RANDOM:8>" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "<TODAY>" in "Answer by"
    And I enter "<RANDOM:8>" in "Aircraft"
    And I enter "<RANDOM:8>" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "<RANDOM:8>" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "<RANDOM:8>" in "Part number"
    And I enter "<RANDOM:8>" in "Description"
    And I enter "1" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Add a supplier"
    And I enter "<RANDOM:8>" in "Supplier name"
    And I enter "sales@supplier.com" in "Email"
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  question_not_answered
  Scenario: Boundary Edge Case - Question Not Answered
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" as Title
    And I enter "<RANDOM:8>" as Wings REQ
    And I select "AOG" as Priority
    And I enter "<TODAY>" as Answer by
    And I enter "<RANDOM:8>" as Aircraft
    And I enter "<RANDOM:8>" as Note to suppliers
    And I select "EXW" as Ask the supplier
    And I enter "<RANDOM:8>" as named place
    And I select "Outright purchase" as Outright/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "<RANDOM:8>" as Part number
    And I enter "<RANDOM:8>" as Description
    And I enter "1" as Quantity
    And I enter "Unit" as Unit
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is Visible

  exchange_core_charge
  Scenario: Boundary Edge Case - Exchange Core Charge
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" as Title
    And I enter "<RANDOM:8>" as Wings REQ
    And I select "AOG" as Priority
    And I enter "<TODAY>" as Answer by
    And I enter "<RANDOM:8>" as Aircraft
    And I enter "<RANDOM:8>" as Note to suppliers
    And I select "EXW" as Ask the supplier
    And I enter "<RANDOM:8>" as named place
    And I select "Exchange" as Outright/Exchange/Repair/Loan
    And I click on "Add a line"
    And I enter "<RANDOM:8>" as Part number
    And I enter "<RANDOM:8>" as Description
    And I enter "1" as Quantity
    And I enter "Unit" as Unit
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is Visible

  exchange_core_due_days
  Scenario: Boundary Edge Case - Exchange Core Due Days
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" in "Title"
    And I enter "<RANDOM:8>" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "<TODAY>" in "Answer by"
    And I enter "<RANDOM:8>" in "Aircraft"
    And I enter "<RANDOM:8>" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "<RANDOM:8>" in "named place"
    And I select "Exchange" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "<RANDOM:8>" in "part number"
    And I enter "<RANDOM:8>" in "description"
    And I enter "1" in "quantity"
    And I enter "each" in "unit"
    And I click on "Add a supplier"
    And I enter "<RANDOM:8>" in "Type to search, or a new name"
    And I enter "sales@supplier.com" in "sales@supplier.com; several with ;"
    And I click on "Save without sending"
    Then I see "Success Message" is "Visible"

  exchange_basis
  Scenario: Boundary Edge Case - Exchange Basis
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" in "Title"
    And I enter "<RANDOM:8>" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "<TODAY>" in "Answer by"
    And I enter "<RANDOM:8>" in "Aircraft"
    And I enter "<RANDOM:8>" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "<RANDOM:8>" in "named place"
    And I select "Exchange" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "<RANDOM:8>" in "part number"
    And I enter "<RANDOM:8>" in "description"
    And I enter "1" in "quantity"
    And I enter "each" in "unit"
    And I click on "Add a supplier"
    And I enter "<RANDOM:8>" in "Type to search, or a new name"
    And I enter "sales@supplier.com" in "sales@supplier.com; several with ;"
    And I click on "Save without sending"
    Then I see "Success Message" is "Visible"

  exchange_o_a_cap
  Scenario: Boundary Edge Case - Exchange O&A Cap
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" in "Title"
    And I enter "<RANDOM:8>" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "<RANDOM:8>" in "Answer by"
    And I enter "<RANDOM:8>" in "Aircraft"
    And I enter "<RANDOM:8>" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "<RANDOM:8>" in "named place"
    And I select "Exchange" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "<RANDOM:8>" in "part number"
    And I enter "<RANDOM:8>" in "description"
    And I enter "<RANDOM:8>" in "quantity"
    And I enter "<RANDOM:8>" in "unit"
    And I click on "Add a supplier"
    And I enter "<RANDOM:8>" in "Type to search, or a new name"
    And I enter "<RANDOM:8>" in "sales@supplier.com; several with ;"
    And I click on "Save without sending"
    Then I see "Success Message" is "Visible"

  exchange_late_core_fee
  Scenario: Boundary Edge Case - Exchange Late Core Fee
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" in "Title"
    And I enter "<RANDOM:8>" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "<RANDOM:8>" in "Answer by"
    And I enter "<RANDOM:8>" in "Aircraft"
    And I enter "<RANDOM:8>" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "<RANDOM:8>" in "named place"
    And I select "Exchange" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "<RANDOM:8>" in "part number"
    And I enter "<RANDOM:8>" in "description"
    And I enter "<RANDOM:8>" in "quantity"
    And I enter "<RANDOM:8>" in "unit"
    And I click on "Add a supplier"
    And I enter "<RANDOM:8>" in "Type to search, or a new name"
    And I enter "<RANDOM:8>" in "sales@supplier.com; several with ;"
    And I click on "Save without sending"
    Then I see "Success Message" is "Visible"

  exchange_core_ber
  Scenario: Boundary Edge Case - Exchange Core BER
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" in "Title"
    And I enter "<RANDOM:8>" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "<TODAY>" in "Answer by"
    And I enter "<RANDOM:8>" in "Aircraft"
    And I enter "<RANDOM:8>" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "<RANDOM:8>" in "named place"
    And I select "Exchange" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "<RANDOM:8>" in "Part number"
    And I enter "<RANDOM:8>" in "Description"
    And I enter "1" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Add a supplier"
    And I enter "<RANDOM:8>" in "Supplier name"
    And I enter "sales@supplier.com" in "Email"
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  loan_terms
  Scenario: Boundary Edge Case - Loan Terms
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" in "Title"
    And I enter "<RANDOM:8>" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "<TODAY>" in "Answer by"
    And I enter "<RANDOM:8>" in "Aircraft"
    And I enter "<RANDOM:8>" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "<RANDOM:8>" in "named place"
    And I select "Loan" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "<RANDOM:8>" in "Part number"
    And I enter "<RANDOM:8>" in "Description"
    And I enter "1" in "Quantity"
    And I enter "Unit" in "Unit"
    And I click on "Add a supplier"
    And I enter "<RANDOM:8>" in "Supplier name"
    And I enter "sales@supplier.com" in "Email"
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @internal_note
  Scenario: Boundary Edge Case - Internal Note Length
    Given I open "http://localhost:3131/rfqs/new"
    When I enter a very long internal note that exceeds the maximum allowed length in the "Internal note" field
    Then I see an error message indicating that the internal note exceeds the maximum length

  @save_without_sending
  Scenario: Boundary Edge Case - Save Without Sending
    Given I open "http://localhost:3131/rfqs/new"
    When I fill out all required fields for an RFQ
    And I click on the "Save without sending" button
    Then I see a confirmation message indicating that the RFQ has been saved without being sent

  @HappyPath @CreateRFQ @ValidInputs @MultipleSuppliers
  Scenario: Happy Path - Create RFQ with Valid Inputs and Multiple Suppliers
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ 123" in "Title"
    And I enter "AW139 C-check parts" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Boeing 737" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "Part1" in "part number"
    And I enter "Description1" in "description"
    And I enter "10" in "quantity"
    And I enter "Unit1" in "unit"
    And I click on "Add a supplier"
    And I enter "supplier1@example.com" in "sales@supplier.com; several with ;"
    And I click on "Add a supplier"
    And I enter "supplier2@example.com" in "sales@supplier.com; several with ;"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible