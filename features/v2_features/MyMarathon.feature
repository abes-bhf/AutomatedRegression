@mymarathon
Feature: MyMarathon form
  In order to start a marathon
  As a supporter
  I want to access the MyMarathon form

  @smoke
  Scenario: MyMarathon form smoke tests
    Given I navigate to the MyMarathon page
    Then The MyMarathon page is displayed

 @missing_from_site
  Scenario: MyMarathon Submission
    Given I navigate to the MyMarathon form
    And I fill in MyMarathon details
    Then I am taken to the MyMarathon confirmation page
