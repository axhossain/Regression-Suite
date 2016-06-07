# This is the initial app startup page for new installs and when your not logged in

# noinspection RubyResolve
class WelcomeScreen < Desk
  trait(:trait) { "editText id:'edit_site_name'" }

  element(:sitename_field) { "editText id:'edit_site_name'" }
  element(:next_button) { "Button id:'sign_in'" }
  element(:background_image) { "ImageView id:'image_logo'" }
  element(:bad_sitename_error) { "TextView text:'#{WELCOME_SCREEN[:invalid_sitename_error][:android]}'" }

  def error_message?
    # noinspection RubyResolve
    element_exists(bad_sitename_error)
  end

  # noinspection RubyResolve
  def enter_sitename(sitename)
    # clear_text_in("editText id:'edit_site_name'")
    # enter_text(sitename_field, sitename)
    # Warning: The method clear_text now clears the text in the currently focused view. Use clear_text_in instead
    # Notice that clear_text_in only clears the text of the first element matching the given query, not all.
    # Use query(query, setText: '') to replicate the old behaviour
    query(sitename_field, setText: sitename)
    touch(next_button)
  end

  def complete?
    element_exists(sitename_field) &&
        element_exists(next_button) &&
        element_exists(background_image)
  end
end
