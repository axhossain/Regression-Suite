Then(/^I search for and open case "([^"]*)"$/) do |text|
  @app.case_filter_screen.await
  @app.case_filter_screen.search('"' + text + '"')
  @app.case_filter_screen.open_case(text)
  @app.case_conversation_screen.await
end

Then(/^I search for "([^"]*)"$/) do |text|
  @app.case_filter_screen.await
  @app.case_filter_screen.search('"' + text + '"')
end

Then(/^I should get (at least)?\s?(\d+) results?$/) do |comparator, item_count|
  @app.case_filter_screen.number_of_items(comparator, item_count)
end