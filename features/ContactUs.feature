@contact
Feature: Contact us form
  In order to enquire about the BHF
  As a BHF website user
  I want to access the Contact us form

  Scenario: Contact us form smoke tests
    Given I navigate to the contact us page
    Then I am taken to the contact us form

  Scenario: Contact us form Submission
    Given I navigate to the contact us page
    And I fill in the contact us form
    Then I am taken to contact us confirmation page
