@donateV2
Feature: Donate Forms V2
  In order to support BHF
  As a supporter
  I want to donate

@fornow @validation @monthly
Scenario: Testing invalid donate widget
  Given I navigate to the donate page
  And I select continue without selecting donation type
  Then donate widget should return with validation messages

Scenario: Testing invalid data on donate widget
  Given I navigate to the donate page
  And I enter an invalid amount in other amount
  Then I should be shown error messages

@happypath @monthly
Scenario: Testing donate widget
  Given I navigate to the donate page
  And I select an amount
  And I fill in details about you
  Then I fill in my address
  And I select this is my own money
  Then add gift aid check hos gift aid
  Then I set up direct debit
  And fill in gdpr
  Then select confirm and pay
  Then I select the donation was in memory and who
  Then I inform a next of kin
  And I add next of kin information
  Then I add a message
  And I add next of kin address
  Then finally the confirmation page is presented
