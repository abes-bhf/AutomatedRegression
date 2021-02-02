@hos
Feature: Heart of steel
As a BHF supporter
I want to engrave a heart of steel

@happypath @submission
Scenario: Valid get started
  Given I navigate to the heart of steel page
  And I select I am over sixteen
  And I fill in engraving details
  And I fill in your details
  Then I fill in my address
  Then I share my story
  And fill in gdpr
  Then I end up in order summary page
  And add donation
  Then add gift aid
  And I press pay via worldpay
  Then I am taken to the Worldpay page
  And I enter valid card details
  Then am presented with the hos confirmation page
