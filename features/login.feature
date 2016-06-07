@login @no-logout
Feature: Ensure Login Screen Functionality

  Scenario: Verify Welcome Page
    Given I am on the Welcome Screen
    Then Welcome Screen is present and complete
  @ios
  Scenario: Verify Bad Site Name
    Given I am on the Welcome Screen
    And I provide a bad site name
    Then I should get the sitename error message

  Scenario: Login (Invalid Password)
    Given I am on the Welcome Screen
    And I supply an invalid password
    Then I should be denied access to the application

  Scenario: Verify an agent can login and log out
    Given I enter proper credentials
    And I log out of the app
    Then I should be on the welcome screen

