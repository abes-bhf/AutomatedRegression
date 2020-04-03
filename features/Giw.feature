@giw
Feature: Gift in wills
  In order to support the BHF website
  As a BHF supporter
  I want to leave a gift in wills

  @liveregression @uatregression @validation
  Scenario: Testing blank validation messages
    Given I navigate to the Gift in wills page
    And I select request your guide
    And I select continue
    And I am taken to your details page of the gift in wills form
    And I select continue without filling details
    Then the gift in wills form should return with validation messages

  @liveregression @uatregression @validation
  Scenario: Testing validation messages for invalid data
    Given I navigate to the Gift in wills page
    And I select request your guide
    And I select continue
    And I am taken to your details page of the gift in wills form
    And I press continue after filling in invalid details on your details page
    Then the gift in wills form should return with validation messages

  @liveregression @uatregression @validation
  Scenario: Testing blank validation on address lookup
    Given I navigate to the Gift in wills page
    And I select request your guide
    And I select continue
    And I navigate to your address page of the gift in wills form
    And validation fires when incorrect address details are entered

  @liveregression @uatregression @validation
  Scenario: Testing blank validation for gdpr
    Given I navigate to the Gift in wills page
    And I select request your guide
    And I select continue
    And I navigate to your address page of the gift in wills form
    And I navigate to the gdpr page of the gift in wills form
    And I select continue without filling in gdpr
    Then the gift in wills form should return with validation messages

  @fornow @liveregression @uatregression @validation
  Scenario: Testing complete Gift in wills form
    Given I navigate to the Gift in wills page
    And I select request your guide
    And I select continue
    And I navigate to your address page of the gift in wills form
    And I navigate to the gdpr page of the gift in wills form
    And I select continue after filling in gdpr
    Then I am taken to the giw confirmation page
    Then I can download gift in wills guide
