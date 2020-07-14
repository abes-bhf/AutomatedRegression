@newsletter
Feature: Newsletter signup page
  In order to learn more about the BHF
  As a supporter
  I want to sign up for the newsletter

  @smoke
  Scenario: Newsletter signup page smoke tests
    Given I navigate to the newsletter signup page
    Then The Newsletter signup page is displayed

  @submission
  Scenario: Newsletter signup
    Given I navigate to the newsletter signup page
    And I sign up for the newsletter
    Then I receive newsletter signup confirmation
