@heart_matters
Feature: Heart Matters form
  In order to enquire about the BHF
  As a BHF website user
  I want to sign up to heart matters magazine


  #Scenario: Contact us form smoke tests
  #  Given I navigate to the contact us page
    #Then I am taken to the contact us form

 @submission 
  Scenario: Heart Matters form submission new registration
    Given I navigate to the heart matters page
    And I click join heart matters
    And I fill in the heart matters form
    Then I am taken to the confirmation page

  @submission
   Scenario: Heart Matters form submission existing user
     Given I navigate to the heart matters page
     And I click join heart matters
     And I fill in the heart matters form as an existing user
     Then I am taken to the confirmation page
