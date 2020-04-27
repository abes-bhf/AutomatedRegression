@dyot
Feature: DYOT form
  In order to start an fundraising event
  As a supporter
  I want to access the DYOT form

  @smoke
  Scenario: DYOT smoke tests
    Given I navigate to the DYOT page
    Then The DYOT page is displayed

  @submission
  Scenario: DYOT Submission
    Given I navigate to the DYOT form
    And I fill in DYOT details
    Then I am taken to the DYOT confirmation page
