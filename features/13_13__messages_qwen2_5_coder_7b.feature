Feature: Web Automation with Behave

  @SendMessage
  Scenario: Send a message from Account A to Account B
    Given I open the TradeHub website
    When I log in to Account A
    And I navigate to the messaging section
    And I enter the message 'Hello from Account A' in the message field
    And I select Account B as the recipient
    And I click on the Send button
    Then I see a confirmation message 'Message sent successfully'

  @OpenAccount
  Scenario: Open Account B
    Given I open the TradeHub website
    When I click on the Register button
    And I enter 'JohnDoe' as Name
    And I enter 'JohnDoeBusiness' as Business Name
    And I enter 'john.doe@example.com' as Email
    And I enter '<RANDOM:8>' as Phone
    And I select 'Trade Business' as Primary Trade
    And I enter 'Sydney' as Suburb/Location
    And I enter '<RANDOM:8>' as Password
    And I click on the Register button
    Then I see a confirmation message 'Account registered successfully'

  @ConfirmMessageAppears
  Scenario: Confirm the message appears in Account B
    Given I open the TradeHub website
    When I log in to Account B
    And I navigate to the messaging section
    Then I see the message 'Hello from Account A' from Account A

  @ReplyMessage
  Scenario: Reply to the message from Account B
    Given I open the TradeHub website
    When I log in to Account B
    And I navigate to the messaging section
    And I click on the message from Account A
    And I enter the reply 'Hello from Account B' in the reply field
    And I click on the Send button
    Then I see a confirmation message 'Reply sent successfully'

  @ConfirmReplyReceived
  Scenario: Confirm Account A receives the reply
    Given I open the TradeHub website
    When I log in to Account A
    And I navigate to the messaging section
    Then I see the reply 'Hello from Account B' from Account B

  @SendMultipleMessages
  Scenario: Send multiple messages from Account A to Account B
    Given I open the TradeHub website
    When I log in to Account A
    And I navigate to the messaging section
    And I enter the message 'First message from Account A' in the message field
    And I select Account B as the recipient
    And I click on the Send button
    And I enter the message 'Second message from Account A' in the message field
    And I select Account B as the recipient
    And I click on the Send button
    Then I see a confirmation message 'Message sent successfully'
    And I see a confirmation message 'Message sent successfully'
    Then I see the message 'First message from Account A' from Account A
    And I see the message 'Second message from Account A' from Account A

  @test_long_messages
  Scenario: Test long messages
    Given I open the messaging application
    When I enter a long message in the message input field
    And I click on the send button
    Then I see the long message is successfully sent and received

  @test_short_messages
  Scenario: Test short messages
    Given I open the messaging application
    When I enter a short message in the message input field
    And I click on the send button
    Then I see the short message is successfully sent and received

  @test_messaging_from_job
  Scenario: Test messaging from a job
    Given I open the messaging application
    When I navigate to a job listing
    And I click on the message button for the job
    Then I see the messaging interface for the job

  @test_messaging_from_tender
  Scenario: Test messaging from a tender if available
    Given I open the messaging application
    When I navigate to a tender listing
    And I click on the message button for the tender
    Then I see the messaging interface for the tender

  @check_unread_message_counts
  Scenario: Check unread message counts
    Given I open the messaging application
    When I navigate to the inbox
    Then I see the correct unread message counts displayed

  @open_conversation
  Scenario: Open the conversation
    Given I open the messaging application
    When I click on a conversation
    Then I see the conversation interface

  @confirm_unread_status_changes
  Scenario: Confirm unread status changes correctly
    Given I open the messaging application
    When I read a message
    Then I see the unread status changes to read

  @test_messaging_on_mobile
  Scenario: Test messaging functionality on mobile
    Given I open the messaging application on a mobile device
    When I send a message
    Then I receive the message on my mobile device

  @send_message_with_empty_title
  Scenario: Send a message with an empty title
    Given I open the messaging application
    When I enter an empty title in the message
    And I enter a valid message body
    And I click on Send
    Then I see an error message indicating that the title cannot be empty

  @send_message_with_null_title
  Scenario: Send a message with a null title
    Given I open the messaging application
    When I enter a null title in the message
    And I enter a valid message body
    And I click on Send
    Then I see an error message indicating that the title cannot be null

  @send_message_with_title_exceeding_limit
  Scenario: Send a message with a title exceeding the character limit
    Given I open the messaging application
    When I enter a title exceeding the character limit in the message
    And I enter a valid message body
    And I click on Send
    Then I see an error message indicating that the title exceeds the character limit

  @send_message_with_invalid_payload
  Scenario: Send a message with an invalid payload
    Given I open the messaging application
    When I enter a valid title in the message
    And I enter an invalid payload in the message
    And I click on Send
    Then I see an error message indicating that the payload is invalid

  @send_message_when_account_not_open
  Scenario: Send a message when Account B is not open
    Given I open the TradeHub website
    When I attempt to send a message to Account B
    Then I receive an error message indicating that Account B is not open

  @send_message_when_account_not_open
  Scenario: Send a message when Account A is not open
    Given I open the TradeHub website
    When I attempt to send a message to Account A
    Then I receive an error message indicating that Account A is not open

