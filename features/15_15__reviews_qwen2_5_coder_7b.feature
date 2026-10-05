Feature: Web Automation with Behave

  @MarkJobAsCompleted
  Scenario: Mark the job as completed
    Given I open the job details page
    When I click on 'Mark as Completed'
    Then I see the 'Job marked as completed' message

  @CheckReviewVisibility
  Scenario: Check the visibility of the review option
    Given I open the job details page
    When I click on 'Mark as Completed'
    Then I see the 'Leave a review' option is visible

  @LeaveReview
  Scenario: Leave a review
    Given I open the job details page
    When I click on 'Mark as Completed'
    And I click on 'Leave a review'
    And I enter 'Great service' in the 'Review' field
    And I select '5' as 'Rating'
    And I click on 'Submit Review'
    Then I see the 'Review submitted successfully' message

  @SubmitRating
  Scenario: Submit a rating
    Given I open the job details page
    When I click on 'Mark as Completed'
    And I click on 'Leave a review'
    And I select '5' as 'Rating'
    And I click on 'Submit Review'
    Then I see the 'Review submitted successfully' message

  @AddWrittenFeedback
  Scenario: Add written feedback
    Given I open the job details page
    When I click on 'Mark as Completed'
    And I click on 'Leave a review'
    And I enter 'Great service' in the 'Review' field
    And I click on 'Submit Review'
    Then I see the 'Review submitted successfully' message

  @ConfirmReviewAppearance
  Scenario: Confirm the review appears on the appropriate business profile
    Given I open the job details page
    When I click on 'Mark as Completed'
    And I click on 'Leave a review'
    And I enter 'Great service' in the 'Review' field
    And I select '5' as 'Rating'
    And I click on 'Submit Review'
    Then I see the review on the business profile

  @Positive
  Scenario: Test the ability to respond to a review
    Given I open the TradeHub website
    When I navigate to the job details page
    And I click on the 'Leave a review' button
    And I enter a valid review title and feedback
    And I click on the 'Submit' button
    Then I see a confirmation message indicating the review has been submitted

  @Negative
  Scenario: Check the Reliability Review process for late cancellations
    Given I open the TradeHub website
    When I navigate to the job details page
    And I click on the 'Cancel' button
    And I select 'Late cancellation' as the reason
    And I click on the 'Submit' button
    Then I see a confirmation message indicating the cancellation has been submitted
    And I see a review prompt for the cancellation

  @Negative
  Scenario: Verify the review option is not visible for uncompleted jobs
    Given I open the TradeHub website
    When I navigate to the job details page
    And I click on the 'Mark as Completed' button
    And I click on the 'Submit' button
    Then I do not see the 'Leave a review' option

  @Negative
  Scenario: Test invalid payload for review submission
    Given I open the TradeHub website
    When I navigate to the job details page
    And I click on the 'Leave a review' button
    And I enter an empty review title and feedback
    And I click on the 'Submit' button
    Then I see an error message indicating the review submission failed

  @Boundary
  Scenario: Test character limits for review title and feedback
    Given I open the TradeHub website
    When I navigate to the job details page
    And I click on the 'Leave a review' button
    And I enter a review title with 8 words and feedback with 18 words
    And I click on the 'Submit' button
    Then I see a confirmation message indicating the review has been submitted

  @Boundary
  Scenario: Test rate limits for review submissions
    Given I open the TradeHub website
    When I navigate to the job details page
    And I click on the 'Leave a review' button
    And I enter a valid review title and feedback
    And I click on the 'Submit' button
    And I wait for the rate limit to expire
    And I click on the 'Leave a review' button again
    And I enter another valid review title and feedback
    And I click on the 'Submit' button
    Then I see a confirmation message indicating the review has been submitted

