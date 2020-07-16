@yahh
Feature: are you fokn jokn
  In order to donate to the BHF
  As a supporter
  I want to request a furniture and electrical collection

  Scenario: Mailsac
    And I visit the Mailsac inbox for my email
    Then There should be an email confirmation of my collection request with expected content
