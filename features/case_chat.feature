@chat
Feature: Ensure chat case specific behaviors

  @ios @wip
  Scenario: Reply to an chat case
    Given I am signed into the application
    And I open the "Chat Channnel" filter
    And I go to the conversation view of a case
    Then I should be able to add a reply to the case

  @ios
  Scenario: Edit the Status of a case
    Given I am signed into the application
    And I open the "Chat Channnel" filter
    And I go to the detailed view of a case
    And I edit the Status of a case
    Then the Status should change

  @ios @wip
  Scenario: Reply to a chat case
    # NOTE:  WIP as there is currently no reply for chat cases on iOS
    Given I am signed into the application
    And I open the "Chat Channnel" filter
    And I go to the conversation view of a case
    And I should be able to add a reply and resolve to the case
    Then I go to detailed view and verify the "Status" should be "Resolved"

  @ios
  Scenario: Add a note to chat case
    Given I am signed into the application
    And I open the "Chat Channnel" filter
    And I go to the conversation view of a case
    Then I should be able to add a note to the case
