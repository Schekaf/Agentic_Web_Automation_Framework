Feature: Web Automation with Behave

  @Logout
  Scenario: Logout
    Given I open "https://www.tradehub.com.au/login"
    When I enter "<RANDOM:8>" as Username
    And I enter "<RANDOM:8>" as Password
    And I click on Login Button
    And I click on Logout Button
    Then I see "Logout Successful" message is visible

  @Re-login
  Scenario: Re-login
    Given I open "https://www.tradehub.com.au/login"
    When I enter "<RANDOM:8>" as Username
    And I enter "<RANDOM:8>" as Password
    And I click on Login Button
    And I click on Logout Button
    And I open "https://www.tradehub.com.au/login"
    When I enter "<RANDOM:8>" as Username
    And I enter "<RANDOM:8>" as Password
    And I click on Login Button
    Then I see "Login Successful" message is visible

  @SessionPersistence
  Scenario: Browser Close and Reopen
    Given I open "https://www.tradehub.com.au/login"
    When I enter "<RANDOM:8>" as Username
    And I enter "<RANDOM:8>" as Password
    And I click on Login Button
    And I close the browser
    And I reopen the browser
    And I open "https://www.tradehub.com.au"
    Then I see "Welcome Back" message is visible

  @SessionBehavior
  Scenario: Check Session Behavior
    Given I open "https://www.tradehub.com.au/login"
    When I enter "<RANDOM:8>" as Username
    And I enter "<RANDOM:8>" as Password
    And I click on Login Button
    And I close the browser
    And I reopen the browser
    And I open "https://www.tradehub.com.au"
    Then I see "Welcome Back" message is visible

  @ForgotPassword
  Scenario: Forgot Password
    Given I open "https://www.tradehub.com.au/login"
    When I click on Forgot Password link
    And I enter "<RANDOM:8>" as Email
    And I click on Submit Button
    Then I see "Password Reset Email Sent" message is visible

  @EmailArrival
  Scenario: Password Reset Email Arrival
    Given I open "https://www.tradehub.com.au/login"
    When I click on Forgot Password link
    And I enter "<RANDOM:8>" as Email
    And I click on Submit Button
    Then I see "Password Reset Email Sent" message is visible
    And I open my email inbox
    Then I see "Password Reset Email" is visible

  @PasswordResetLinkValidity
  Scenario: Password Reset Link Validity
    Given I open the TradeHub website
    When I navigate to the Password Reset page
    And I enter a valid email address
    And I click on the Reset Password button
    Then I receive a password reset email
    And I click on the password reset link in the email
    Then I am directed to the password reset form
    And I enter a new password
    And I confirm the new password
    And I click on the Update Password button
    Then I am logged in with the new password

  @UnexpectedLogout
  Scenario: Unexpected Logout
    Given I am logged in to the TradeHub website
    When I perform a series of actions without logging out
    Then I remain logged in

  @LoginLoop
  Scenario: Login Loop
    Given I am on the TradeHub login page
    When I enter valid login credentials
    And I click on the Login button
    Then I am redirected to the dashboard

  @IncorrectRedirects
  Scenario: Incorrect Redirects
    Given I am logged in to the TradeHub website
    When I click on a link that should redirect to a different page
    Then I am redirected to the correct page

  @PasswordResetIssues
  Scenario: Password Reset Issues
    Given I am logged in to the TradeHub website
    When I navigate to the Password Reset page
    And I enter an invalid email address
    And I click on the Reset Password button
    Then I receive an error message indicating the email address is invalid

  @AccessiblePages
  Scenario: Accessible Pages When Logged Out
    Given I am logged out of the TradeHub website
    When I navigate to the Home page
    Then I can see the Home page without being prompted to log in
    And I navigate to the Jobs page
    Then I can see a limited number of jobs without being prompted to log in
    And I navigate to the Tenders page
    Then I see blurred/restricted information and am prompted to Sign Up/Login

  @InvalidPassword
  Scenario: Invalid Password
    Given I open "https://www.tradehub.com.au/login"
    When I enter "<RANDOM:8>" as Username
    And I enter "invalidpassword" as Password
    And I click on Login Button
    Then I see "Invalid password" is visible

  @EmptyUsername
  Scenario: Empty Username
    Given I open "https://www.tradehub.com.au/login"
    When I enter "" as Username
    And I enter "password123" as Password
    And I click on Login Button
    Then I see "Username cannot be empty" is visible

  @EmptyPassword
  Scenario: Empty Password
    Given I open "https://www.tradehub.com.au/login"
    When I enter "username123" as Username
    And I enter "" as Password
    And I click on Login Button
    Then I see "Password cannot be empty" is visible

  @NegativePassword
  Scenario: Negative Password
    Given I open "https://www.tradehub.com.au/login"
    When I enter "username123" as Username
    And I enter "-password123" as Password
    And I click on Login Button
    Then I see "Invalid password" is visible

  @MaxPasswordLength
  Scenario: Max Password Length
    Given I open "https://www.tradehub.com.au/login"
    When I enter "username123" as Username
    And I enter "<RANDOM:100>" as Password
    And I click on Login Button
    Then I see "Password exceeds maximum length" is visible

  @RateLimiting
  Scenario: Rate Limiting
    Given I open "https://www.tradehub.com.au/login"
    When I enter "username123" as Username
    And I enter "password123" as Password
    And I click on Login Button
    And I wait for 1 minute
    And I click on Login Button again
    Then I see "Too many login attempts" is visible

