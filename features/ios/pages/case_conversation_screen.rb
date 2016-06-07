require 'calabash-cucumber/ibase'
require 'byebug'

# noinspection RubyResolve,RubyResolve
class CaseConversationScreen < Desk
  include DeskiOS::IOSHelpers

  trait(:trait) {"view marked:'Reply'"}

  element(:conversation_tab) {"segmentLabel marked:'Conversation'"}
  element(:details_tab) {"label marked:'Case Details'"}
  element(:conversation) { 'textView' }
  element(:reply_more_info) {"imageView id:'ConversationItemMoreInfo'"}
  element(:done_button) {"navigationButton marked:'Done'"}
  element(:cancel_button) {"navigationButton marked:'Cancel'"}
  element(:reply_button) {"button marked:'Reply'"}
  element(:reassign_button) {"button marked:'Assign'"}
  element(:note_button) {"button marked:'Note'"}
  element(:macro_button) {"button marked:'Macro'"}
  element(:send_button) {"label marked:'Send'"}
  element(:send_resolve_button) {"label marked:'Send + Resolve'"}
  element(:save_changes_button) {"label marked:'Save Changes'"}
  element(:draft_label) {"label marked:'DRAFT'"}
  element(:twitter_reply_mention) {"label marked:'Mention'"}
  element(:twitter_reply_dm) {"label marked:'DM'"}
  element(:back_button) { "button marked:'BackArrowWhite'"}

  action(:touch_back_button) {touch(back_button)}
  action(:touch_details_tab) {touch(details_tab)}
  action(:touch_done_button) {touch(done_button)}
  action(:touch_cancel_button) {touch(cancel_button)}
  action(:touch_reply_button) {touch(reply_button)}
  action(:touch_reassign_button) {touch(reassign_button)}
  action(:touch_note_button) {touch(note_button)}
  action(:touch_macro_button) {touch(macro_button)}
  action(:touch_send_button) {touch(send_button)}
  action(:touch_send_resolve_button) {touch(send_resolve_button)}
  action(:touch_save_changes_button) {touch(save_changes_button)}
  action(:touch_twitter_reply_mention) {touch(twitter_reply_mention)}
  action(:touch_twitter_reply_dm) {touch(twitter_reply_dm)}

  def enter_new_conversation(characters=50)
    sleep 3
    wait_for_none_animating
    @new_conversation = enter_text_characters('textView', characters)
  end

  def enter_new_twitter_reply(characters=50)
    sleep 0.5
    wait_for_none_animating
    @current_text = query('textView', :text).first
    current_length = @current_text.length
    available_length = MAX_TWITTER_LENGTH - current_length
    if characters.is_a? Integer
      @new_conversation = enter_text_characters('textView', characters, { wait_for_keyboard: false, prepend_whitespace: 1})
      @new_conversation = @current_text + @new_conversation
    else
      case characters
        when 'max'
          @entered_text = enter_twitter_reply(available_length)
          @new_conversation = expected_twitter_reply(@current_text, @entered_text, available_length)
          # byebug
        when 'more than max'
          @entered_text = enter_twitter_reply(available_length, 10)
          @new_conversation = expected_twitter_reply(@current_text, @entered_text, available_length)
        else
          fail 'unknown reply type'
      end
      wait_for_elements_exist(["textView text:'#{@new_conversation}'"])
      wait_for_elements_exist(["label marked:'Name:' sibling label marked:'0'"])
    end
  end

  def enter_twitter_reply(available_length, exceed_by=0)
    enter_text_characters('textView', available_length + exceed_by, { wait_for_keyboard: false, prepend_whitespace: 1})
  end

  def expected_twitter_reply(current_text, entered_text, available_length)
    return current_text + entered_text[0...available_length].chomp
  end

  def save_draft(body)
    touch_cancel_button
    sleep 0.5
    wait_for_element_exists(save_changes_button)
    touch_save_changes_button
    wait_for_elements_do_not_exist([ save_changes_button ])
    wait_for_cloud
    verify_draft
    verify_conversation(body)
  end

  def verify_draft
    wait_for_element_exists draft_label
    check_element_exists draft_label
  end

  def send_conversation(type)
    touch_done_button
    sleep 1
    case type
      when 'reply','mention','dm'
        touch_send_button
      when 'reply and resolve', 'mention and resolve', 'dm and resolve'
        touch_send_resolve_button
      when 'note'
        # no special action needed
      else
        fail 'Unknown send type'
    end

    sleep 1
    wait_for_none_animating
    verify_conversation
  end

  def verify_conversation(text=@new_conversation)
    query = "textView {text CONTAINS '#{text}'}"

    wait_for_cloud
    wait_for_none_animating
    sleep 3

    wait_for_element_exists(query)
    check_element_exists(query)
  end

  def switch_twitter_reply_type(type)
    sleep 1
    wait_for_none_animating
    if element_exists(twitter_reply_mention) && (type == 'dm' || type == 'dm and resolve')
      touch_twitter_reply_mention
      sleep 1
      touch_twitter_reply_dm
      touch_back_button
      sleep 1
    elsif element_exists(twitter_reply_dm) && (type == 'mention' || type == 'mention and resolve')
      touch_twitter_reply_dm
      sleep 1
      touch_twitter_reply_mention
      touch_back_button
      sleep 1
    end
    case type
      when 'mention', 'mention and resolve'
        check_element_exists(twitter_reply_mention)
      when 'dm', 'dm and resolve'
        check_element_exists(twitter_reply_dm)
      else
        fail 'Unknown twitter message type'
    end
  end
end
