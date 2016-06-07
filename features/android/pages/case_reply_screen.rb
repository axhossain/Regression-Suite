require_relative '../../../features/android/droid_base'
require 'pry'

# noinspection RubyResolve,RubyResolve
class CaseReplyScreen < Desk
  include DeskAndroid::AndroidHelpers

  element(:outbound_email_address) {"TextView {text CONTAINS 'support'}"}
  element(:ok_button) { "button marked:'OK'"}

  action(:touch_back_button) { touch(back_button) }

  def select_email_address_fields(address_field)
    # address_field = 'TO' if address_field == 'To'
    query = ("TextView {text CONTAINS '#{address_field}'}")

    case address_field
      when 'support'
        touch(query)
        touch(ok_button)
      when 'TO','CC','BCC'
        touch(query)
    end
    check_element_exists(outbound_email_address)
  end
end