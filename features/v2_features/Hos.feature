@hos
Feature: Heart of steel
As a BHF supporter
I want to engrave a heart of steel

@validation @uatregression
Scenario: Testing blank validation on first two pages
  Given I navigate to heart of steel page
  And I select continue without selecting 16 and over
  Then a validation message should appear
  And I select continue without filling in engraving details
  Then engraving details validation message should appear

@validation @uatregression
Scenario: Testing invalid data on engraving details
  Given I navigate to heart of steel page
  And I select I am over 16
  And I enter invalid data on engraving details
  Then engraving details validation message should appear
