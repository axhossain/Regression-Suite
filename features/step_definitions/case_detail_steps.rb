And(/^I go to the (conversation|detailed) view of a case$/) do |page|
  @app.case_filter_screen.await
  @app.case_filter_screen.touch_a_case
  @app.case_conversation_screen.await
  sleep 1
  if page == 'detailed'
    @app.case_conversation_screen.touch_details_tab
    @app.case_details_screen.await
  end
end

And(/^I open a case that is not "([^"]*)"$/) do |status|
  @app.case_filter_screen.await
  @app.case_filter_screen.open_case_not_status(status)
  @app.case_conversation_screen.await
  #waits below were added because sometimes await finishes and then the loading cloud appears.
  sleep 1
end

And(/^I edit the (Agent|Group|Status|Priority|Community Answers) of a case$/) do |field|
  @app.case_details_screen.await
  @app.case_details_screen.enter_edit_mode(field)
  case field
    when 'Priority'
      @app.case_priority_screen.await
      @app.case_priority_screen.choose_random_priority(@app.case_details_screen.original_value)
    when 'Status'
      @app.case_status_screen.await
      @app.case_status_screen.choose_random_status(@app.case_details_screen.original_value)
    when 'Agent','Group'
      @app.case_assign_screen.await
      @app.case_assign_screen.choose_random_agent(@app.case_details_screen.original_value)
    when 'Community Answers'
      @app.case_community_answers_screen.await
      @app.case_community_answers_screen.choose_opposite_community(@app.case_details_screen.original_value)
    else
      fail 'Unknown action'
  end
  @app.case_details_screen.wait_value_change(field)
end

And(/^I edit the (Boolean|List|Text|Number|Date) custom field of a case$/) do |field|
  @app.case_details_screen.enter_edit_mode(field)
  @app.case_custom_field_screen.await

  case field
    when 'Boolean'
      @app.case_custom_field_screen.switch_opposite_boolean(
        @app.case_details_screen.original_value)
    when 'List'
      @app.case_custom_field_screen.choose_random_list_item(
        @app.case_details_screen.original_value)
    when 'Text'
      @app.case_custom_field_screen.enter_custom_field_text
    when 'Number'
      @app.case_custom_field_screen.enter_custom_field_number
    when 'Date'
      @app.case_custom_field_screen.choose_random_date(@app.case_details_screen.original_value)
    else
      fail 'Unknown action'
  end

  sleep 1 if @app.ios? # FIXME
  @app.case_details_screen.wait_value_change(field)
end

And(/^I view all Agents$/) do
  @app.case_details_screen.await
  @app.case_details_screen.enter_edit_mode('Group')
  @app.case_assign_screen.choose_unassigned_group
  @app.case_details_screen.await
  if ENV['PLATFORM'] == 'android'
    @app.case_details_screen.check_unassigned_group
  end
  @app.case_details_screen.enter_edit_mode('Agent')
end

Then(/^I verify Agent name is not public name$/) do
  @app.case_assign_screen.await
  @app.case_assign_screen.check_agent_public_name
end


Then(/^the (Agent|Group|Priority|Status|Community Answers) should change$/) do |field|
  @app.case_details_screen.await
  case field
    when 'Priority'
      @app.case_details_screen.verify_detail(field, @app.case_priority_screen.new_value)
    when 'Status'
      @app.case_details_screen.verify_detail(field, @app.case_status_screen.new_value)
    when 'Agent','Group'
      @app.case_details_screen.verify_detail(field, @app.case_assign_screen.new_value)
    when 'Community Answers'
      @app.case_details_screen.verify_detail(field, @app.case_community_answers_screen.new_value)
    else
      fail 'Unknown action'
  end
end

Then(/^the (Boolean|List|Text|Number|Date) custom field should change$/) do |field|
  @app.case_details_screen.verify_detail(field, @app.case_custom_field_screen.new_value)
end

And(/^I (add|remove) a Label (to|from) a case$/) do |action, preposition|
  until_ios_labels_have_probably_changed = 5

  @app.case_details_screen.await
  @app.case_details_screen.enter_edit_labels
  @app.case_label_screen.await

  @app.case_label_screen.await
  case action
    when 'add'
      @app.case_label_screen.add_label(@app.case_details_screen.original_value)
      sleep until_ios_labels_have_probably_changed if ios?
    when 'remove'
      @app.case_label_screen.remove_label(@app.case_details_screen.original_value)
    else
      fail 'Unknown action'
  end

  @app.case_details_screen.wait_value_change('Label') unless ios?
end

Then(/^a Label should be (added|removed)$/) do |action|
  @app.case_details_screen.await
  @app.case_details_screen.enter_edit_labels
  @app.case_label_screen.await

  original_value = @app.case_details_screen.original_value
  new_value = @app.case_label_screen.new_value

  # TODO:  Condense / consider similar logic for android
  if ios?
    selected = action == 'added'
    @app.case_label_screen.verify_label(new_value, selected)
    @app.case_label_screen.touch_back_button
    @app.case_details_screen.await
  else
    @app.case_details_screen.verify_label_change(action, original_value, new_value)
  end
end

Then(/^I go to detailed view and verify the "([^"]*)" should be "([^"]*)"$/) do |field, value|
  @app.case_conversation_screen.await
  @app.case_conversation_screen.touch_details_tab
  @app.case_details_screen.await
  @app.case_details_screen.verify_detail(field, value)
end


And(/^I go to the detailed view of a (0|1) label case$/) do |label|
  @app.case_filter_screen.await
  @app.case_filter_screen.touch_a_label_case(label)
  @app.case_conversation_screen.await
  @app.case_conversation_screen.touch_details_tab
  @app.case_details_screen.await
end

When(/^I open each case to verify attachments$/) do
  @app.case_conversation_screen.await
  @app.case_conversation_screen.touch_details_tab
  @app.case_details_screen.await
  scroll "UITableView", :down
  sleep(5)
  scroll "UITableView", :down
end

Then(/^I should be able to download the "(.*?)" attachments with "(.*?)" and "(.*?)"$/) do |file_size, attachment_name,file_size_status|
  query = ("label {text CONTAINS 'Tap to download'}")
  wait_for_elements_exist([query])
  touch(query)
  @app.case_details_screen.await
  @app.case_details_screen.verify_downloaded_content(file_size,attachment_name,file_size_status)
end

When (/^I assign the case to "([^"]*)"$/) do |agent_name|
  @app.case_assign_screen.await
  @app.case_assign_screen.choose_me_agent(agent_name)
end
