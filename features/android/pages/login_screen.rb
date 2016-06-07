# After entering sitename, or if user simply signed out.  This page will prompt for login credentials. This is the web login page.

class LoginScreen < Desk

  trait(:trait) { "WebView css:'#user_session_email'" }

  element(:login_email) { "WebView css:'#user_session_email'" }
  element(:login_password) { "WebView css:'#user_session_password'" }
  element(:login_button) { "WebView css:'#user_session_submit'" }

  # noinspection RubyResolve
  def enter_login_info(email, pass)
    sleep 1
    enter_text(login_email, email)
    enter_text(login_password, pass)
    scroll_to(login_button)
    touch(login_button)
  end
end