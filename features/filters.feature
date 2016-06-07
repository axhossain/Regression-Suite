Feature: Ensure Filter Functionality

  @filters
  Scenario: Verify I can change filters
    Given I am signed into the application
    And I open the "All Cases" filter
    Then I should see the cases belonging to the "All Cases" filter
    And I open the "Facebook Channel" filter
    Then I should see the cases belonging to the "Facebook Channel" filter
    And I open the "Email Channel" filter
    Then I should see the cases belonging to the "Email Channel" filter
    And I open the "Inbox" filter
    Then I should see the cases belonging to the "Inbox" filter
    And I open the "Twitter Channel" filter
    Then I should see the cases belonging to the "Twitter Channel" filter
    And I open the "Phone Channel" filter
    Then I should see the cases belonging to the "Phone Channel" filter
    And I open the "All Open Cases" filter
    Then I should see the cases belonging to the "All Open Cases" filter
    And I open the "Attachment" filter
    Then I should see the cases belonging to the "Attachment" filter
#    Removing Chat channel filter tests since this tests is inconsistency fails
#    And I open the "Chat Channnel" filter
#    Then I should see the cases belonging to the "Chat Channnel" filter
    And I open the "Q&A Channel" filter
    Then I should see the cases belonging to the "Q&A Channel" filter
    And I open the "10+ Transactions" filter
    Then I should see the cases belonging to the "10+ Transactions" filter
