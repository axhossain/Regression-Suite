require 'byebug'

And /^I select the cases on screen for bulk editing$/ do
  @app.case_filter_screen.await
  @app.case_filter_screen.wait_for_bulk_edit
  @app.case_filter_screen.select_all_items_in_view
end

And(/^I reassign the cases$/) do
  @app.case_filter_screen.touch_bulk_assign
  @app.case_assign_screen.await
  @app.case_assign_screen.choose_random_group_and_agent
  @app.case_filter_screen.wait_timestamp_change
end

Then(/^the cases should be reassigned$/) do
  @app.case_filter_screen.touch_a_case
  @app.case_conversation_screen.await
  @app.case_conversation_screen.touch_details_tab
  @app.case_details_screen.await
  @app.case_details_screen.verify_group(@app.case_assign_screen.group)
  @app.case_details_screen.verify_agent(@app.case_assign_screen.agent)
end

And(/^I change the status of the cases$/) do
  @app.case_filter_screen.get_status
  @app.case_filter_screen.touch_bulk_status
  @app.case_status_screen.await
  @app.case_status_screen.choose_random_status (@app.case_filter_screen.original_status)
  @app.case_filter_screen.wait_status_change
end

Then(/^the statuses should be changed$/) do
  @app.case_filter_screen.await
  @app.case_filter_screen.verify_status(@app.case_status_screen.new_value)
end

And(/^I change the label of the cases$/) do
  @app.case_filter_screen.touch_bulk_label
  @app.case_label_screen.await
  @app.case_label_screen.choose_random_label
  @app.case_filter_screen.wait_label_change(@app.case_label_screen.new_value)
end

Then(/^the label should be changed$/) do
  @app.case_filter_screen.await
  @app.case_filter_screen.verify_label(@app.case_label_screen.new_value)
end
