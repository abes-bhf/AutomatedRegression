Feature: House Clearance form
  In order to donate to the BHF
  As a supporter
  I want to request a House Clearance

   Scenario: User navigation smoke tests
    And I navigate to the House Clearance form
    Then The House Clearance form is displayed
    And The HC how did you hear dropdown should be displayed with the expected options
    And The reason for requesting dropdown should be displayed with the expected options

   Scenario: HC Submission
    Given I navigate to the HC form
    And I fill in house clearance details
    Then I am taken to the HC confirmation page with a collection reference


  @hcvalid
  Scenario: HC Validation check
    Given I navigate to the House Clearance form
    And I submit the HC form without filling fields
    Then The HC form should refresh with validation messages

  @hcsubmit
  Scenario: HC Validation check
    Given I navigate to the House Clearance form
    And I fill in house clearance details with invalid data
    Then The HC form should refresh with validation messages
