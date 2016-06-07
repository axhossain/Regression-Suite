# After entering sitename, or if user simply signed out.  This page will prompt for login credentials. This is the web login page.

class CrashScreen < Desk

  trait(:trait) { "dialogTitle text:'Crash Data'" }

  element(:dismiss_button) { "button text:'Dismiss'" }

  action(:touch_dismiss_button) {touch(dismiss_button)}
end