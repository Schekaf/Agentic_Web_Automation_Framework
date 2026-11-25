Feature: Order Placement

  @PlaceOrderValidSupplierLines
  Scenario: Place order with valid supplier lines
    Given I open "http://localhost:3131"
    When I click on "Order Management"
    And I click on "New Order"
    And I enter "AW139 C-check parts" in "Title"
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
    Then I see "Order saved successfully" is visible

  @PlaceOrderZeroLineItems
  Scenario: Place order with zero line items
    Given I open "http://localhost:3131"
    When I click on "Order Management"
    And I click on "New Order"
    And I enter "AW139 C-check parts" in "Title"
    And I enter "RQ-1234" in "Wings REQ"
    And I select "AOG" as "Priority"
    And I enter "2023-12-31" in "Answer by"
    And I enter "Boeing 737" in "Aircraft"
    And I enter "Shipping to another base" in "Note to suppliers"
    And I select "EXW" as "Delivery terms"
    And I enter "New York JFK" in "named place"
    And I select "Outright purchase" as "Outright purchase/Exchange/Repair/Loan"
    And I click on "Save without sending"
    Then I see "Order saved successfully" is visible

  @PlaceOrderNegativeQuantity
  Scenario: Place order with negative quantity
    Given I open "http://localhost:3131/orders/new"
    When I enter "-1" in "Quantity"
    Then I see "Negative quantity is not allowed" is visible

  @PlaceOrderMaxQuantity
  Scenario: Place order with max quantity
    Given I open "http://localhost:3131/orders/new"
    When I enter "1000" in "Quantity"
    Then I see "Order placed successfully" is visible

  @PlaceOrderEmptySupplier
  Scenario: Place order with empty supplier
    Given I open "http://localhost:3131"
    When I click on "Order Placement"
    And I click on "Add a line"
    And I click on "Add a supplier"
    And I click on "Save without sending"
    Then I see "Supplier is required" is visible

  @PlaceOrderInvalidSupplier
  Scenario: Place order with invalid supplier
    Given I open "http://localhost:3131"
    When I click on "Order Placement"
    And I click on "Add a line"
    And I enter "invalid_supplier@company.com" in "sales@supplier.com; several with ;"
    And I click on "Save without sending"
    Then I see "Invalid supplier email" is visible

  @PlaceOrderMissingNegotiationRecord
  Scenario: Place order with missing negotiation record
    Given I open "http://localhost:3131/orders/new"
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
    Then I see "Order saved successfully" is visible

  @PlaceOrderDuplicateSupplierLines
  Scenario: Place order with duplicate supplier lines
    Given I open "http://localhost:3131/orders/new"
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
    And I click on "Add a line"
    And I enter "123456" in "part number"
    And I enter "Part Description" in "description"
    And I enter "10" in "quantity"
    And I enter "Unit" in "unit"
    And I click on "Add a supplier"
    And I enter "supplier@company.com" in "sales@supplier.com; several with ;"
    And I enter "Internal note for the team" in "Internal note"
    And I click on "Save without sending"
    Then I see "Duplicate supplier lines" is visible

  @PlaceOrderEmptyNegotiationFields
  Scenario: Place order with empty negotiation record fields
    Given I open "http://localhost:3131/orders/new"
    When I click on "Place Order"
    Then I see "Negotiation record fields are required" is visible

  @PlaceOrderMaxNegotiationFields
  Scenario: Place order with max negotiation record fields
    Given I open "http://localhost:3131/orders/new"
    When I enter "<RANDOM:8>" as Negotiation Field 1
    And I enter "<RANDOM:8>" as Negotiation Field 2
    And I enter "<RANDOM:8>" as Negotiation Field 3
    And I enter "<RANDOM:8>" as Negotiation Field 4
    And I enter "<RANDOM:8>" as Negotiation Field 5
    And I enter "<RANDOM:8>" as Negotiation Field 6
    And I enter "<RANDOM:8>" as Negotiation Field 7
    And I enter "<RANDOM:8>" as Negotiation Field 8
    And I click on "Place Order"
    Then I see "Order placed successfully" is visible

  @PlaceOrderWithExchangeLine
  Scenario: Place order with exchange line
    Given I open "http://localhost:3131/orders/new"
    When I enter "AW139 C-check parts" in "Title"
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
    Then I see "Order saved successfully" is visible

  @PlaceOrderAllSupplierLines
  Scenario: Place order with all lines from a supplier
    Given I open "http://localhost:3131/orders/new"
    When I enter "AW139 C-check parts" in "Title"
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
    Then I see "Order saved successfully" is visible

