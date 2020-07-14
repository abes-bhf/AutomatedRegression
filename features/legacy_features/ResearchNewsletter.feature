@research @newsletter
Feature: Research newsletter signup page
  In order to learn more about the BHF
  As a supporter
  I want to sign up for the research newsletter

  @smoke
  Scenario: Research newsletter signup page smoke tests
    Given I navigate to the research newsletter signup page
    Then The research newsletter signup page is displayed

  @submission
  Scenario: Research newsletter signup
    Given I navigate to the research newsletter signup page
    And I sign up for the research newsletter
    Then I receive research newsletter signup confirmation
