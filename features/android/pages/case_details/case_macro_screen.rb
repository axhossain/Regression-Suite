# noinspection RubyResolve,RubyResolve
class CaseMacroScreen < Desk
  include DeskAndroid::AndroidHelpers

  attr_reader :subject, :reply, :priority, :status

  trait(:trait) {"listView textView index:0"}

  element(:apply_button) {"textView text:'APPLY'"}

  action(:touch_apply_button) {touch(apply_button)}

  def preview_macro(prev_body, name='Thanks for feedback + Resolve')
    macro_element = "textView text:'#{name}'"
    if element_does_not_exist(macro_element)
      touch("textView text:'Sample Macros'")
      sleep 1
    end
    wait_for_element_exists(macro_element)
    touch(macro_element)
    wait_for(:timeout => 10, :retry_frequency => 0.5, :post_timeout => 0.5, :timeout_message => 'Apply button not loaded') do
      element_exists(apply_button)
    end

    case name
      when 'Thanks for feedback + Resolve'
        @reply = prev_body.concat(MACROS[:thanks_for_feedback_resolve_macro_reply])
        @priority = '3'
        @status = 'Resolved'
        wait_for_element_exists("editText text:'#{@reply}'")
        wait_for_element_exists("textView text:'Priority' sibling textView text:'#{@priority}'")
        wait_for_element_exists("textView text:'Status' sibling textView text:'#{@status}'")

      when 'More info + Pending'
        @reply = prev_body.concat(MACROS[:more_info_pending_reply])
        @priority = '5'
        @status = 'Pending'
        wait_for_element_exists("editText text:'#{@reply}'")
        wait_for_element_exists("textView text:'Priority' sibling textView text:'#{@priority}'")
        wait_for_element_exists("textView text:'Status' sibling textView text:'#{@status}'")
      else
        fail 'Unknown macro'
    end
  end

  def apply_macro(type, go_back = true)
    @subject = query("editText index:0", :text).first
    @subject.slice! 'Re: '
    touch_apply_button
    sleep 1
    element = "textView id:'message_body'"
    wait_for_element_exists(element)
    press_back_button if go_back
    sleep 1
  end
end
