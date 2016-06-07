require 'calabash-cucumber/ibase'

# noinspection RubyResolve,RubyResolve
class CaseMacroScreen < Desk
  include DeskiOS::IOSHelpers

  attr_reader :subject, :reply, :priority, :status

  trait(:trait) {"searchBar"}

  element(:done_button) {"navigationButton marked:'Done'"}
  element(:next_button) {"navigationButton marked:'Next'"}
  element(:apply_button) {"navigationButton marked:'Apply'"}
  element(:update_send_button) {"label marked:'Update + Send'"}
  element(:update_send_resolve_button) {"label marked:'Update, Send + Resolve'"}
  element(:label_item) {'tableViewCellContentView'}
  element(:back_button) { "button marked:'BackArrowWhite'"}

  action(:touch_back_button) {touch(back_button)}
  action(:touch_done) {touch(done_button)}
  action(:touch_apply_button) {touch(apply_button)}
  action(:touch_next_button) {touch(next_button)}
  action(:touch_update_send_button) {touch(update_send_button)}
  action(:touch_update_send_resolve_button) {touch(update_send_resolve_button)}

  def preview_macro(name='Thanks for feedback + Resolve')
    touch("view marked:'#{name}'")
    touch_next_button
    wait_for_elements_exist(['tableViewCell'])
    wait_for_none_animating
    case name
      when 'Thanks for feedback + Resolve'
        @reply = MACROS[:thanks_for_feedback_resolve_macro_reply]
        @priority = '3'
        @status = 'Resolved'
        check_element_exists("textView text:'#{@reply}'")
        check_element_exists("view marked:'Priority' sibling label marked:'#{@priority}'")
        check_element_exists("view marked:'Status' sibling label marked:'#{@status}'")

      when 'More info + Pending'
        @reply = MACROS[:more_info_pending_reply]
        @priority = '5'
        @status = 'Pending'
        check_element_exists("textView text:'#{@reply}'")
        check_element_exists("view marked:'Priority' sibling label marked:'#{@priority}'")
        check_element_exists("view marked:'Status' sibling label marked:'#{@status}'")
      else
        fail 'Unknown macro'
    end
  end

  def apply_macro(type, go_back = true)
    @subject = query("tableViewCell index:0 label", :text).first
    touch_apply_button
    sleep 1
    case type
      when 'apply'
        touch_update_send_button
      when 'apply and resolve'
        touch_update_send_resolve_button
        @status = 'Resolved'
      else
        fail 'Unknown apply type'
    end
  end

  def search(text)
    enter_text('textField', text)
  end
end