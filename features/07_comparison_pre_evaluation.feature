Feature: Web Automation with Behave

  @HappyPathCreateRFQWithValidInputs
  Scenario: Happy Path - Create RFQ with Valid Inputs
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ" in "Title"
    And I enter "<RANDOM:8>" in "reqRef"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "respondBy"
    And I enter "AW139" in "aircraft"
    And I enter "Shipping to another base" in "noteToSuppliers"
    And I select "EXW" as "incoterm"
    And I enter "New York" in "named place"
    And I select "Outright purchase" as "line_type"
    And I enter "1" in "quantity"
    And I enter "Unit" in "unit"
    And I enter "supplier@supplier.com" in "supplier"
    And I enter "1000" in "price"
    And I enter "2024-01-31" in "validity"
    And I enter "<RANDOM:8>" in "last_agreed"
    And I enter "<RANDOM:8>" in "charges_not_included"
    And I enter "<RANDOM:8>" in "standing"
    And I enter "<RANDOM:8>" in "reason"
    And I enter "<RANDOM:8>" in "delivery_terms"
    And I enter "100" in "core_charge"
    And I enter "10" in "core_due_days"
    And I enter "<RANDOM:8>" in "basis"
    And I enter "10000" in "o_a_cap"
    And I enter "500" in "late_core_fee"
    And I enter "1000" in "core_ber"
    And I enter "100" in "no_fault_found_fees"
    And I enter "10000" in "ber_limit"
    And I enter "<RANDOM:8>" in "question_not_answered"
    And I enter "1000" in "landed_cost"
    And I enter "100" in "exchange_core_charge"
    And I enter "10" in "exchange_core_due_days"
    And I enter "<RANDOM:8>" in "exchange_basis"
    And I enter "10000" in "exchange_o_a_cap"
    And I enter "500" in "exchange_late_core_fee"
    And I enter "1000" in "exchange_core_ber"
    And I enter "<RANDOM:8>" in "loan_terms"
    And I enter "<RANDOM:8>" in "internal_note"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @NegativePathInvalidTitle
  Scenario: Negative Path - Invalid Title
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "" in "Title"
    And I enter "<RANDOM:8>" in "reqRef"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "respondBy"
    And I enter "AW139" in "aircraft"
    And I enter "Shipping to another base" in "noteToSuppliers"
    And I select "EXW" as "incoterm"
    And I enter "New York" in "named place"
    And I select "Outright purchase" as "line_type"
    And I enter "1" in "quantity"
    And I enter "Unit" in "unit"
    And I enter "supplier@supplier.com" in "supplier"
    And I enter "1000" in "price"
    And I enter "2024-01-31" in "validity"
    And I enter "<RANDOM:8>" in "last_agreed"
    And I enter "<RANDOM:8>" in "charges_not_included"
    And I enter "<RANDOM:8>" in "standing"
    And I enter "<RANDOM:8>" in "reason"
    And I enter "<RANDOM:8>" in "delivery_terms"
    And I enter "100" in "core_charge"
    And I enter "10" in "core_due_days"
    And I enter "<RANDOM:8>" in "basis"
    And I enter "10000" in "o_a_cap"
    And I enter "500" in "late_core_fee"
    And I enter "1000" in "core_ber"
    And I enter "100" in "no_fault_found_fees"
    And I enter "10000" in "ber_limit"
    And I enter "<RANDOM:8>" in "question_not_answered"
    And I enter "1000" in "landed_cost"
    And I enter "100" in "exchange_core_charge"
    And I enter "10" in "exchange_core_due_days"
    And I enter "<RANDOM:8>" in "exchange_basis"
    And I enter "10000" in "exchange_o_a_cap"
    And I enter "500" in "exchange_late_core_fee"
    And I enter "1000" in "exchange_core_ber"
    And I enter "<RANDOM:8>" in "loan_terms"
    And I enter "<RANDOM:8>" in "internal_note"
    And I click on "Save without sending"
    Then I see "Title is required" is visible

  @priority
  Scenario: Negative Path - Invalid Priority
    Given I open "http://localhost:3131/rfqs/new"
    When I select "Invalid Priority" as "Priority"
    Then I see "Invalid Priority" is not selected as "Priority"

  @incoterm
  Scenario: Negative Path - Invalid Incoterm
    Given I open "http://localhost:3131/rfqs/new"
    When I select "Invalid Incoterm" as "Delivery terms"
    Then I see "Invalid Incoterm" is not selected as "Delivery terms"

  @supplier
  Scenario: Negative Path - Invalid Supplier
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "InvalidSupplier" in "Supplier"
    And I click on "Add a line"
    And I click on "Save without sending"
    Then I see "Invalid supplier" is selected as "Supplier"

  @line_type
  Scenario: Negative Path - Invalid Line Type
    Given I open "http://localhost:3131/rfqs/new"
    When I select "InvalidLineType" as "Line Type"
    And I click on "Add a line"
    And I click on "Save without sending"
    Then I see "Invalid line type" is selected as "Line Type"

  @price
  Scenario: Negative Path - Invalid Price
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "123" as "Price"
    Then I see "Invalid price" is visible

  @validity
  Scenario: Negative Path - Invalid Validity
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid_date" as "Validity"
    Then I see "Invalid validity" is visible

  @last_agreed
  Scenario: Negative Path - Invalid Last Agreed
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid_last_agreed_price" in "Last Agreed" field
    And I click on "Save without sending"
    Then I see "Invalid last agreed price" error message is visible

  @charges_not_included
  Scenario: Negative Path - Invalid Charges Not Included
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid_charges_not_included" in "Charges Not Included" field
    And I click on "Save without sending"
    Then I see "Invalid charges not included" error message is visible

  @standing
  Scenario: Negative Path - Invalid Standing
    Given I open "http://localhost:3131/rfqs/new"
    When I select "InvalidStanding" as "Standing"
    And I click on "Save without sending"
    Then I see "Invalid standing" is selected as "Standing"

  @reason
  Scenario: Negative Path - Invalid Reason
    Given I open "http://localhost:3131/rfqs/new"
    When I select "InvalidReason" as "Reason"
    And I click on "Save without sending"
    Then I see "Invalid reason" is selected as "Reason"

  delivery_terms
  Scenario: Negative Path - Invalid Delivery Terms
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "InvalidIncoterm" in "Delivery terms"
    And I enter "InvalidPlace" in "named place"
    And I click on "Save without sending"
    Then I see "Invalid delivery terms" is selected as "Delivery terms"

  core_charge
  Scenario: Negative Path - Invalid Core Charge
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "InvalidCoreCharge" in "Core Charge"
    And I click on "Save without sending"
    Then I see "Invalid core charge" is selected as "Core Charge"

  @core_due_days
  Scenario: Negative Path - Invalid Core Due Days
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "-1" in "Core Due Days" field
    And I click on "Save without sending" button
    Then I see "Invalid core due days" error message is visible

  @basis
  Scenario: Negative Path - Invalid Basis
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Invalid Basis" in "Basis" field
    And I click on "Save without sending" button
    Then I see "Invalid basis" error message is visible

  @o_a_cap
  Scenario: Negative Path - Invalid O&A Cap
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid_o_and_a_cap" in "O&A Cap" field
    And I click on "Save without sending"
    Then I see "Invalid O&A Cap" error message is visible

  @late_core_fee
  Scenario: Negative Path - Invalid Late Core Fee
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid_late_core_fee" in "Late Core Fee" field
    And I click on "Save without sending"
    Then I see "Invalid Late Core Fee" error message is visible

  @core_ber
  Scenario: Negative Path - Invalid Core BER
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid_core_ber" in "Core BER" field
    And I click on "Save without sending"
    Then I see "Invalid Core BER" error message is visible

  @no_fault_found_fees
  Scenario: Negative Path - Invalid No-Fault Found Fees
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid_no_fault_found_fees" in "No-Fault Found Fees" field
    And I click on "Save without sending"
    Then I see "Invalid No-Fault Found Fees" error message is visible

  ber_limit
  Scenario: Negative Path - Invalid BER Limit
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid_ber_limit" in "BER Limit" field
    And I click on "Save without sending"
    Then I see "Invalid BER Limit" error message is visible

  question_not_answered
  Scenario: Negative Path - Invalid Question Not Answered
    Given I open "http://localhost:3131/rfqs/new"
    When I click on "Add a line"
    And I enter "part_number" in "Part Number" field
    And I enter "description" in "Description" field
    And I enter "quantity" in "Quantity" field
    And I enter "unit" in "Unit" field
    And I click on "Save without sending"
    Then I see "Invalid Question Not Answered" error message is visible

  exchange_core_charge
  Scenario: Negative Path - Invalid Exchange Core Charge
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid_charge" in "Exchange Core Charge" field
    And I click on "Save without sending"
    Then I see "Invalid exchange core charge" error message is visible

  exchange_core_due_days
  Scenario: Negative Path - Invalid Exchange Core Due Days
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid_due_days" in "Exchange Core Due Days" field
    And I click on "Save without sending"
    Then I see "Invalid exchange core due days" error message is visible

  @exchange_basis
  Scenario: Negative Path - Invalid Exchange Basis
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Invalid Basis" in "Outright purchase"
    And I click on "Save without sending"
    Then I see "Invalid exchange basis" is selected as "Outright purchase"

  @exchange_o_a_cap
  Scenario: Negative Path - Invalid Exchange O&A Cap
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Invalid O&A Cap" in "Outright purchase"
    And I click on "Save without sending"
    Then I see "Invalid O&A cap" is selected as "Outright purchase"

  @exchange_late_core_fee
  Scenario: Negative Path - Invalid Exchange Late Core Fee
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid_fee" in "Exchange Late Core Fee" field
    And I click on "Save without sending"
    Then I see "Invalid Exchange Late Core Fee" error message is visible

  @exchange_core_ber
  Scenario: Negative Path - Invalid Exchange Core BER
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid_ber" in "Exchange Core BER" field
    And I click on "Save without sending"
    Then I see "Invalid Exchange Core BER" error message is visible

  loan_terms
  Scenario: Negative Path - Invalid Loan Terms
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid loan terms" in "Delivery terms"
    And I click on "Save without sending"
    Then I see "Invalid loan terms" is selected as "Delivery terms"

  internal_note
  Scenario: Negative Path - Invalid Internal Note
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "invalid internal note" in "Internal note"
    And I click on "Save without sending"
    Then I see "Invalid internal note" in "Internal note" Values

  @save_without_sending
  Scenario: Negative Path - Invalid Save Without Sending
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Wings REQ" in "Title"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I click on "Save without sending"
    Then I see "Save without sending" is "Disabled"

  @title
  Scenario: Boundary Edge Case - Title Length
    Given I open "http://localhost:3131/rfqs/new"
    When I enter a title with the maximum length in "Title"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is Visible

  @ObjectiveLength
  Scenario: Boundary Edge Case - Objective Length
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" in "Title"
    Then I see "Title" is "<RANDOM:8>"

  @PriceIndex
  Scenario: Boundary Edge Case - Price Index
    Given I open "http://localhost:3131/rfqs/new"
    When I select "Lowest" as "Price Index"
    Then I see "Price Index" is "Lowest"
    When I select "Highest" as "Price Index"
    Then I see "Price Index" is "Highest"

  @arrival
  Scenario: Boundary Edge Case - Arrival Against Need Date
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" in "Title"
    And I enter "<RANDOM:8>" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "<TODAY>" in "Answer by"
    And I enter "<TODAY>" in "Arrival Against Need Date"
    And I click on "Add a line"
    And I enter "1" in "Quantity"
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @validity
  Scenario: Boundary Edge Case - Validity
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" in "Title"
    And I enter "<RANDOM:8>" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "<TODAY>" in "Answer by"
    And I enter "<TODAY>" in "Validity Start Date"
    And I enter "<TODAY>" in "Validity End Date"
    And I click on "Add a line"
    And I enter "1" in "Quantity"
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

  @last_agreed
  Scenario: Boundary Edge Case - Last Agreed
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "Lowest Last Agreed Price" in "Last Agreed Price" field
    And I enter "Highest Last Agreed Price" in "Last Agreed Price" field
    Then I see "RFQ Created Successfully" message is visible

  @charges_not_included
  Scenario: Boundary Edge Case - Charges Not Included
    Given I open "http://localhost:3131/rfqs/new"
    When I select "Maximum Charges Not Included" as "Charges Not Included" option
    And I select "Minimum Charges Not Included" as "Charges Not Included" option
    Then I see "RFQ Created Successfully" message is visible

  @standing
  Scenario: Boundary Edge Case - Standing
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" in "Title"
    And I enter "<RANDOM:8>" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "<RANDOM:8>" in "Answer by"
    And I enter "<RANDOM:8>" in "Aircraft"
    And I enter "<RANDOM:8>" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "<RANDOM:8>" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "<RANDOM:8>" in "Part number"
    And I enter "<RANDOM:8>" in "Description"
    And I enter "<RANDOM:8>" in "Quantity"
    And I enter "<RANDOM:8>" in "Unit"
    And I click on "Add a supplier"
    And I enter "<RANDOM:8>" in "Type to search, or a new name"
    And I enter "<RANDOM:8>" in "sales@supplier.com; several with ;"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @reason
  Scenario: Boundary Edge Case - Reason
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" in "Title"
    And I enter "<RANDOM:8>" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "<RANDOM:8>" in "Answer by"
    And I enter "<RANDOM:8>" in "Aircraft"
    And I enter "<RANDOM:8>" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "<RANDOM:8>" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Add a line"
    And I enter "<RANDOM:8>" in "Part number"
    And I enter "<RANDOM:8>" in "Description"
    And I enter "<RANDOM:8>" in "Quantity"
    And I enter "<RANDOM:8>" in "Unit"
    And I click on "Add a supplier"
    And I enter "<RANDOM:8>" in "Type to search, or a new name"
    And I enter "<RANDOM:8>" in "sales@supplier.com; several with ;"
    And I click on "Save without sending"
    Then I see "RFQ created successfully" is visible

  @core_charge
  Scenario: Boundary Edge Case - Core Charge
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" as Core Charge
    Then I see "Core Charge" is "<RANDOM:8>"

  @core_due_days
  Scenario: Boundary Edge Case - Core Due Days
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" as Core Due Days
    Then I see "Core Due Days" is "<RANDOM:8>"

  @basis
  Scenario: Boundary Edge Case - Basis
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" in "Title"
    And I enter "<RANDOM:8>" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "<TODAY>" in "Answer by"
    And I enter "<RANDOM:8>" in "Aircraft"
    And I enter "<RANDOM:8>" in "Note to suppliers"
    And I select "EXW" as "Ask the supplier"
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

  @o_a_cap
  Scenario: Boundary Edge Case - O&A Cap
    Given I open "http://localhost:3131/rfqs/new"
    When I enter "<RANDOM:8>" in "Title"
    And I enter "<RANDOM:8>" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "<TODAY>" in "Answer by"
    And I enter "<RANDOM:8>" in "Aircraft"
    And I enter "<RANDOM:8>" in "Note to suppliers"
    And I select "EXW" as "Ask the supplier"
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
    And I enter "<RANDOM:8>" in "Supplier name"
    And I enter "sales@supplier.com" in "Email"
    And I click on "Save without sending"
    Then I see "RFQ saved successfully" is visible

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
    And I enter "<RANDOM:8>" in "Answer by"
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
    And I enter "<RANDOM:8>" in "Answer by"
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

