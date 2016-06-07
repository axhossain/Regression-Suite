Then(/^I should be able to add a (note|reply|reply and resolve) to the case$/) do |type|
  case type
    when 'note'
      @app.case_conversation_screen.touch_note_button
    when 'reply', 'reply and resolve'
      @app.case_conversation_screen.await
      sleep 3
      @app.case_conversation_screen.touch_reply_button
    else
      fail 'Unknown conversation type'
  end
  @app.case_conversation_screen.enter_new_conversation
  @app.case_conversation_screen.send_conversation(type)
end

Then(/^I should be able to add a draft to the case$/) do
  @app.case_conversation_screen.touch_reply_button
  body = @app.case_conversation_screen.enter_new_conversation(10)
  @app.case_conversation_screen.save_draft(body)
end

Then(/^I should (be|not be) able to add a (mention|dm|mention and resolve|dm and resolve) to the case with (max|more than max) characters$/) do |action,type, characters|
  @app.case_conversation_screen.touch_reply_button
  @app.case_conversation_screen.switch_twitter_reply_type(type) if ENV['PLATFORM'] == 'ios'
  @app.case_conversation_screen.enter_new_twitter_reply(characters)
  case action
    when 'be'
      @app.case_conversation_screen.send_conversation(type)
    when 'not be'
      #do nothing
    else
      fail 'Unknown reply action'
  end
end

And(/^I view the list of macros$/) do 
  @app.case_conversation_screen.touch_macro_button
end

And(/^I search the list of macros for "([^"]*)"$/) do |text|
  @app.case_macro_screen.await
  @app.case_macro_screen.search(text)
end

And(/^I should be able to preview macro "([^"]*)"$/) do |macro|
  @app.case_conversation_screen.touch_macro_button
  @app.case_macro_screen.await
  if ENV['PLATFORM'] == 'ios'
    @app.case_macro_screen.preview_macro(macro)
  end
  if ENV['PLATFORM'] == 'android'
    @app.case_macro_screen.preview_macro(@app.case_conversation_screen.body, macro)
  end
end

Then(/^I should be able to (apply|apply and resolve) a macro$/) do |action|
  @app.case_macro_screen.apply_macro(action)
  @app.case_filter_screen.await

  if ENV['PLATFORM'] == 'ios'
    @app.case_filter_screen.open_case(@app.case_macro_screen.subject)
  end
  if ENV['PLATFORM'] == 'android'
    #assumes you don't modify subject
    @app.case_filter_screen.open_prev_case
  end

  @app.case_conversation_screen.await
  @app.case_conversation_screen.verify_conversation(@app.case_macro_screen.reply)
  @app.case_conversation_screen.touch_details_tab
  @app.case_details_screen.await
  @app.case_details_screen.verify_detail('Priority',@app.case_macro_screen.priority)
  @app.case_details_screen.verify_detail('Status',@app.case_macro_screen.status)
end

Then(/^I should be able to edit a macro$/) do
  field = PRIORITY_FIELD
  action = APPLY_ACTION

  @app.case_details_screen.enter_edit_mode(field)

  @app.case_priority_screen.await
  @app.case_priority_screen.choose_random_priority(@app.case_details_screen.original_value)
  new_value = @app.case_priority_screen.new_value

  sleep 1
  @app.case_macro_screen.apply_macro(action, false)

  @app.case_conversation_screen.await
  @app.case_conversation_screen.touch_details_tab

  @app.case_details_screen.await
  @app.case_details_screen.verify_detail(field, new_value)
end

Then(/^I should see the customer profile for "(.*?)"$/) do |search|
  @app.case_conversation_screen.await
  @app.case_conversation_screen.touch_details_tab
  @app.case_details_screen.await
  @app.case_details_screen.enter_edit_mode('Customer')
  @app.case_customer_screen.await
  @app.case_customer_screen.verify_details(search)
end

Then(/^I should see the company profile for "([^"]*)"$/) do |search|
  @app.case_conversation_screen.await
  @app.case_conversation_screen.touch_details_tab
  @app.case_details_screen.await
  @app.case_details_screen.enter_edit_mode('Customer')
  @app.case_customer_screen.await
  @app.case_customer_screen.touch_company_tab
  @app.case_company_screen.await
  @app.case_company_screen.verify_details(search)
end

Then(/^I should see the custom field for "([^"]*)"$/) do |search|
  @app.case_conversation_screen.await
  @app.case_conversation_screen.touch_details_tab
  @app.case_details_screen.await
  @app.case_details_screen.verify_details(search)
end


Then(/^I should be able to discard a draft to the case$/) do
  oldbody = @app.case_conversation_screen.get_latest_conversation_body
  @app.case_conversation_screen.touch_reply_button
  @app.case_conversation_screen.enter_new_conversation(10)
  @app.case_conversation_screen.discard_draft(oldbody)
end

Then(/^I should be able to add a reply and select best answer to the case$/) do
  @app.case_conversation_screen.touch_reply_button
  @app.case_conversation_screen.enter_new_conversation
  @app.case_conversation_screen.touch_best_answer_for_reply
  @app.case_conversation_screen.send_conversation('reply')
end

And(/^I should be able to change reply to best answer$/) do
  @app.case_conversation_screen.select_best_answer_from_more_info
end

Then(/^I should be able to verify that reply should be best answer$/) do
  @app.case_conversation_screen.verify_best_answer_for_reply
end

Then(/^I should be able to verify that reply should be hidden$/) do
  @app.case_conversation_screen.verify_hidden_for_reply
end

And(/^I should be able to change reply to hidden post$/) do
  @app.case_conversation_screen.select_hidden_from_more_info
end

When (/^I add a reply to the case$/) do
  sleep 5
  @app.case_conversation_screen.touch_reply_button
end

Then (/^I should be able to verify email address fields "([^"]*)"$/) do |address_field|
  sleep 3
  @app.case_reply_screen.select_email_address_fields(address_field)
end
