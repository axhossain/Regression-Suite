# This is the initial app startup page for new installs and when your not logged in

# noinspection RubyResolve,RubyResolve,RubyResolve,RubyResolve,RubyResolve,RubyResolve
class WelcomeScreen < Desk
  include DeskiOS::IOSHelpers
  trait(:trait) { "label marked:'#{WELCOME_SCREEN[:sitename_text]}'" }

  element(:sitename_field) { 'UITextField index:0' }
  element(:next_button) { "button marked:'Next'" }
  element(:background_image) { "imageView id:'LoginBackground'" }
  element(:error) { "UILabel text:'Error'" }
  element(:bad_sitename_error) { "label {text CONTAINS '#{WELCOME_SCREEN[:invalid_sitename_error][:ios]}'}" }

  def error_message?
    element_exists(error) && element_exists(bad_sitename_error)
  end

  def exists?
    element_exists(trait)
  end

  def complete?
    self.exists? &&
    check_element_exists(sitename_field) &&
        check_element_exists(next_button) &&
    check_element_exists(background_image)
  end

  def enter_sitename(sitename)
    clear_text(sitename_field)
    enter_text(sitename_field, sitename)
    touch(next_button)
  end

end
