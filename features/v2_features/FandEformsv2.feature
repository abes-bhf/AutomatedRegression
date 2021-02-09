@fnev2
Feature: Furniture and Electrical collection
  In order to donate to the BHF
  As a supporter
  I want to request a furniture and electrical collection


  @submission
  Scenario: F and E Submission
    Given I navigate to the F and E form v2
    And I fill in the F and E form v2
    Then I am taken to the F and E form v2 confirmation page


  @liveregression @transactionless
  Scenario: F and E Submission
    Given I navigate to the F and E form v2
    And I fill in the F and E form v2
