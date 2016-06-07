# noinspection RubyResolve
require 'calabash-cucumber/ibase'

class LoginScreen < Desk
  include DeskiOS::IOSHelpers

  trait(:trait) { "UIWebView css:'.nomargin-bottom'" }
  element(:login_email) { "UIWebView css:'#user_session_email'" }
  element(:login_password) { "UIWebView css:'#user_session_password'" }
  element(:login_button) { "UIWebView css:'#user_session_submit'" }

  # noinspection RubyResolve
  def enter_login_info(email, pass)
    enter_text(login_email, email)
    enter_text(login_password, pass)
    touch(login_button)
  end

  # noinspection RubyResolve
  def exists?
    sleep(5)
    element_exists(login_button)
  end

end