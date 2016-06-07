require 'calabash-cucumber/ibase'

# noinspection RubyResolve,RubyResolve
class CaseReplyScreen < Desk
  include DeskiOS::IOSHelpers

  element(:outbound_email_address) {"label {text CONTAINS 'support'}"}
  element(:back_button) { "button marked:'BackArrowWhite'"}

  action(:touch_back_button) { touch(back_button) }

  def select_email_address_fields(address_field)
    wait_for_elements_exist(["label {text CONTAINS '#{address_field}'}"])
    query = ("label {text CONTAINS '#{address_field}'}")
    case address_field
      when 'outbound'
        touch(query)
        touch(back_button)
      when 'To','CC','BCC'
        touch(query)
    end
    check_element_exists(outbound_email_address)
  end
end