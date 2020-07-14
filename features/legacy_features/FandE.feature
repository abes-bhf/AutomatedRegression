@fnehc
Feature: Furniture and Electrical collection
  In order to donate to the BHF
  As a supporter
  I want to request a furniture and electrical collection

  @fnesmoke @egg @egg1
  Scenario: User navigation smoke tests
    Given I navigate to the F and E form
    Then The F and E form is displayed
    And The F and E how did you hear dropdown should be displayed with the expected options
    And I navigate to the House Clearance form
    Then The House Clearance form is displayed
    And The HC how did you hear dropdown should be displayed with the expected options
    And The reason for requesting dropdown should be displayed with the expected options


  @blank @validation @fne
  Scenario: F and E blank Validation check
    Given I navigate to the F and E form
    And I submit the F and E form without filling fields
    Then The F and E form should refresh with blank validation messages

  @invalid @validation @fne
  Scenario: F and E invalid Validation check
    Given I navigate to the F and E form
    And I submit the F and E form with invalid data
    Then The F and E form should refresh with validation messages

  @submission @fne @egg @egg2
  Scenario: F and E Submission
    Given I navigate to the F and E form
    And I fill in furniture collection details
    Then I am taken to the F and E confirmation page with a collection reference

  @hcvalid
  Scenario: HC Validation check
    Given I navigate to the House Clearance form
    And I submit the HC form without filling fields
    Then The HC form should refresh with validation messages

  @hcsubmit
  Scenario: HC Validation check
    Given I navigate to the House Clearance form
    And I fill in house clearance details
    Then I am taken to the HC confirmation page with a collection reference

  @fnesubmit
  Scenario: F and E Submission
    Given I navigate to the F and E form
    And I fill in furniture collection details
    Then I am taken to the F and E confirmation page with a collection reference
    And I visit the Mailsac inbox for my email
    Then There should be an email confirmation of my collection request with expected content
