class CaseConversationScreen < Desk
  include DeskAndroid::AndroidHelpers

  attr_reader :body

  trait(:trait) {"textView marked:'REPLY'"}

  element(:conversation_tab) {"textView marked:'Conversation'"}
  element(:details_tab) {"textView marked:'Case Details'"}
  element(:conversation) { "textView id:'message_body'" }
  element(:reply_more_info) {"imageView id:'more_info'"}
  element(:done_button) {"actionMenuItemView id:'action_send'"}
  element(:done_note_button) {"actionMenuItemView id:'action_menu_send'"}
  element(:reply_button) {"textView marked:'REPLY'"}
  element(:reassign_button) {"textView marked:'Reassign'"}
  element(:note_button) {"textView marked:'NOTE'"}
  element(:macro_button) {"textView marked:'MACRO'"}
  element(:send_button) {"textView marked:'Send'"}
  element(:send_resolve_button) {"textView marked:'Send and Resolve'"}
  element(:body_edit) {"editText id:'body_edit'"}
  element(:dialog_save_button) {"button text:'Save'"}
  element(:dialog_discard_button) {"button text:'Discard'"}
  element(:draft_indicator) {"textView id:'draft_indicator'"}
  element(:message_body) {"textView id:'message_body'"}
  element(:is_best_answer_reply_checkbox) {"checkbox id:'is_best_answer'"}
  element(:more_info) {"imageView id:'more_info'"}
  element(:more_info_best_answer) {"checkedTextView text:'Best Answer'"}
  element(:more_info_hidden) {"checkedTextView text:'Hidden Post'"}
  element(:more_info_button_ok) {"button text:'OK'"}

  action(:touch_details_tab) {touch(details_tab)}
  action(:touch_done_button) {touch(done_button)}
  action(:touch_done_note_button) {touch(done_note_button)}
  action(:touch_reply_button) {touch(reply_button)}
  action(:touch_reassign_button) {touch(reassign_button)}
  action(:touch_note_button) {touch(note_button)}
  action(:touch_send_button) {touch(send_button)}
  action(:touch_send_resolve_button) {touch(send_resolve_button)}
  action(:touch_dialog_save_button) {touch(dialog_save_button)}
  action(:touch_dialog_discard_button) {touch(dialog_discard_button)}
  action(:touch_best_answer_for_reply) {touch(is_best_answer_reply_checkbox)}
  action(:touch_show_more_messages) {touch(show_more_messages)}

  def enter_new_conversation (characters=50)
    @new_conversation = enter_text_characters(body_edit, characters)
  end

  def enter_new_twitter_reply (characters=50)
    sleep 1
    message_body_query_string = "editText id:'body_edit'"
    current_count_query = "textView id:'chars'"
    wait_for(:timeout => 10, :post_timeout => 1, :timeout_message => 'Mention name did not appear') do
      @current_text = query(message_body_query_string, :text).first
      @current_text != nil && @current_text != ''
    end
    current_length = @current_text.length
    available_length = MAX_TWITTER_LENGTH - current_length - 1 # -1 because we are adding a space
    enter_text(message_body_query_string, ' ')
    if characters.is_a? Integer
      @new_conversation = enter_text_characters(message_body_query_string, characters)
      @new_conversation = @current_text + ' ' + @new_conversation
    else
      case characters
        when 'max'
          @new_conversation = enter_text_characters(message_body_query_string, available_length)
          @new_conversation = @current_text + ' ' + @new_conversation
        when 'more than max'
          @new_conversation = enter_text_characters(message_body_query_string, available_length + 10)
          @new_conversation = @current_text + ' ' + @new_conversation[0...available_length].chomp
        else
          fail 'unknown reply character count'
      end
    end
    wait_for_element_exists(message_body_query_string + " text:'#{@new_conversation}'", :timeout => 10)
    wait_for_element_exists(current_count_query + " text:'0'", :timeout => 3)
  end

  def send_conversation(type)
    body = query(body_edit, :text).first
    while body.empty?
      enter_new_conversation
      body = query(body_edit, :text).first
    end

    case type
      when 'reply','mention','dm'
        touch_done_button
        sleep 1
        touch_send_button
      when 'reply and resolve', 'mention and resolve', 'dm and resolve'
        touch_done_button
        sleep 1
        touch_send_resolve_button
      when 'note'
        touch_done_note_button
      else
        fail 'Unknown send type'
    end
    sleep 1
    self.verify_conversation
  end

  def get_latest_conversation_body
    query(message_body, :getText).last
  end

  def verify_conversation(text=@new_conversation)
    wait_poll(:until_exists => message_body, :timeout => 10, :retry_frequency => 1, :post_timeout => 1, :timeout_message => "Couldn't find the body TextView") do
      wait_for_element_exists("textView id:'message_body' text:'#{text}'")
    end
  end

  def verify_draft
    wait_for_element_exists(draft_indicator)
  end

  def save_draft(body)
    press_back_button
    wait_for_element_exists(dialog_save_button)
    touch_dialog_save_button
    sleep 1
    verify_draft
    verify_conversation(body)
  end

  def discard_draft(oldbody)
    press_back_button
    wait_for_element_exists(dialog_discard_button)
    touch_dialog_discard_button
    sleep 1
    verify_conversation(oldbody)
  end

  def touch_macro_button
    wait_for_element_exists(message_body)
    @body = ''
    @body = query(message_body, :text).first if element_exists(draft_indicator)
    touch(macro_button)
  end

  def verify_best_answer_for_reply(text=@new_conversation)
    wait_poll(:until_exists => message_body, :timeout => 10, :retry_frequency => 1, :post_timeout => 1, :timeout_message => "Couldn't find the body TextView") do
      wait_for_element_exists("relativeLayout id:'is_best_answer' sibling textView id:'message_body' text:'#{text}'")
    end
  end

  def select_best_answer_from_more_info
    touch(query(more_info).last)
    wait_for_element_exists(more_info_best_answer)
    touch(more_info_best_answer)
    touch(more_info_button_ok)
  end

  def verify_hidden_for_reply(text=@new_conversation)
    wait_poll(:until_exists => message_body, :timeout => 10, :retry_frequency => 1, :post_timeout => 1, :timeout_message => "Couldn't find the body TextView") do
      wait_for_element_exists("relativeLayout id:'hidden' sibling textView id:'message_body' text:'#{text}'")
    end
  end

  def select_hidden_from_more_info
    touch(query(more_info).last)
    wait_for_element_exists(more_info_hidden)
    touch(more_info_hidden)
    touch(more_info_button_ok)
  end
end