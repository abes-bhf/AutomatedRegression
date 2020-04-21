Feature: DYOT form
  In order to start an fundraising event
  As a supporter
  I want to access the DYOT form

   Scenario: DYOT smoke tests
    Given I navigate to the DYOT form
    Then The DYOT form is displayed

   Scenario: DYOT Submission
    Given I navigate to the DYOT form
    And I fill in DYOT details
    Then I am taken to the DYOT confirmation page
