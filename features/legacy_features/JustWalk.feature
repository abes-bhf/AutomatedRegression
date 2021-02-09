@jw
Feature: Just Walk form
  In order to plan my own sponsored walk
  As a supporter
  I want to access the Just Walk form

  @smoke
  Scenario: JW smoke tests
    Given I navigate to the JW form
    Then The JW form is displayed

  @submission
  Scenario: JW Submission
    Given I navigate to the JW form
    And I fill in JW details
    Then I am taken to the JW confirmation page

  @liveregression @transactionless
  Scenario: JW Submission
    Given I navigate to the JW form
    And I fill in JW details
