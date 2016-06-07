# TODO:  Macro scenarios WIP until https://desk.atlassian.net/browse/AA-30738
Feature: Ensure Case Conversation actions

  Scenario: Add a note to case
    Given I am signed into the application
    And I go to the conversation view of a case
    Then I should be able to add a note to the case

  @wip
  Scenario: Should be able to use a macro on a case
    Given I am signed into the application
    And I go to the conversation view of a case
    And I should be able to preview macro "Thanks for feedback + Resolve"
    Then I should be able to apply a macro

  @wip
  Scenario: Should be able to edit and apply a macro on a case
    Given I am signed into the application
    And I go to the conversation view of a case
    And I should be able to preview macro "More info + Pending"
    Then I should be able to edit a macro

  @ios @wip
  Scenario: Should be able to use a macro and resolve a case
    Given I am signed into the application
    And I go to the conversation view of a case
    And I should be able to preview macro "More info + Pending"
    Then I should be able to apply and resolve a macro

  @conversation @ios @wip
  Scenario: Should be able to edit the agent while previewing a macro on a case
    Given I am signed into the application
    And I go to the conversation view of a case
    And I should be able to preview macro "More info + Pending"
    And I edit the Agent of a case
    Then the Agent should change

  @ios @wip
  Scenario: Should be able to edit the group while previewing a macro on a case
    Given I am signed into the application
    And I go to the conversation view of a case
    And I should be able to preview macro "More info + Pending"
    And I edit the Group of a case
    Then the Group should change

  @ios @wip
  Scenario: Should be able to edit the priority while previewing a macro on a case
    Given I am signed into the application
    And I go to the conversation view of a case
    And I should be able to preview macro "More info + Pending"
    And I edit the Priority of a case
    Then the Priority should change

  @ios @wip
  Scenario: Should be able to edit the status while previewing a macro on a case
    Given I am signed into the application
    And I go to the conversation view of a case
    And I should be able to preview macro "More info + Pending"
    And I edit the Status of a case
    Then the Status should change

  Scenario: Add a draft to case
    Given I am signed into the application
    And I open the "Email Channel" filter
    And I go to the conversation view of a case
    Then I should be able to add a draft to the case

  @android
  Scenario: Cancel a draft to case
    Given I am signed into the application
    And I go to the conversation view of a case
    Then I should be able to discard a draft to the case

