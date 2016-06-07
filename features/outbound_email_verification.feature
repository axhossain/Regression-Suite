@outbound
Feature: Check if case details has outbound email

  Scenario: Open a case and check if case details has outbound email
    Given I am signed into the application
    And I search for and open case "Company Profile"
    When I add a reply to the case
    Then I should be able to verify email address fields "support"

  Scenario: Open a case and check if case details has outbound email
    Given I am signed into the application
    And I search for and open case "Company Profile"
    When I add a reply to the case
    Then I should be able to verify email address fields "To"

  Scenario: Open a case and check if case details has outbound email
    Given I am signed into the application
    And I search for and open case "Company Profile"
    When I add a reply to the case
    Then I should be able to verify email address fields "CC"

  Scenario: Open a case and check if case details has outbound email
    Given I am signed into the application
    And I search for and open case "Company Profile"
    When I add a reply to the case
    Then I should be able to verify email address fields "BCC"
