@house_clearance_v2
Feature: House Clearance
  In order to donate to the BHF
  As a supporter
  I want to request a house clearance


  @submission
  Scenario: House Clearance v2 submission
    Given I navigate to the house clearance landing page
    And I submit a valid postcode
    Then I am able to complete the house clearance form
