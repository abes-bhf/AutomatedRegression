@flow
Feature: FLOW
  In order to process furniture and electrical collections
  As a store worker
  I want to use FLOW

  Scenario: User navigates to FLOW login page
    Given I navigate to the FLOW URL
    Then the FLOW login page is displayed

  @here
  Scenario: View collection request
    Given I log into flow
    And I view requests for all shops
    And I search for a collection reference
    Then the request will be displayed
    Given I view more details about the request
    Then I should see more info about the request
    And I can either accept or decline the request

  Scenario: F and E Submission checked in flow
    Given I navigate to the F and E form
    And I fill in furniture collection details
    Then I am taken to the F and E confirmation page with a collection reference
    Given I log into flow
    And I search for the collection reference
    Then my collection request is displayed
