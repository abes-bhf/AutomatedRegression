@donateV2
Feature: Donate Forms V2
  In order to support BHF
  As a supporter
  I want to donate


@uatregression @validation @monthly
Scenario: Testing donate widget
  Given I navigate to the donate page
  And I select continue without selecting donation type
  Then donate widget should return with validation messages

Scenario: Testing invalid data on donate widget
  Given I navigate to the donate page
  And I enter an invalid amount in other amount
  Then I should be shown error messages
