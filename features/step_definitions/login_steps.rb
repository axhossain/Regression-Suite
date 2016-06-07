Given(/^I am on the Welcome Screen$/) do
  @app = page(DeskApp)
end

Then(/^Welcome Screen is present and complete$/) do
  if ENV['PLATFORM'] == 'ios'
    expect(@app.welcome_screen.complete?).to be nil
  end
  if ENV['PLATFORM'] == 'android'
    @app.welcome_screen.complete?
  end
end

Given(/^I provide a bad site name$/) do
  @app.welcome_screen.await
  @app.welcome_screen.enter_sitename(INVALID_DATA[:sitename])
end

Then /^I should get the (\w+) error message$/ do |error|
  sleep 1
  case error
    when 'sitename'
      expect(@app.welcome_screen.error_message?).to be true
    else
      fail('unknown error has occured')
  end
end

Given(/^I supply an invalid password$/) do
  @app.welcome_screen.await
  @app.welcome_screen.enter_sitename(VALID_USER[:sitename])
  if ENV['PLATFORM'] == 'ios'
    @app.login_screen.await
  end
  if ENV['PLATFORM'] == 'android'
    wait_for(:timeout => 10, :retry_frequency => 0.5, :post_timeout => 0.5, :timeout_message => 'Login screen not loaded') do
      @app.login_screen.current_page?
    end
  end
  @app.login_screen.enter_login_info(VALID_USER[:email], INVALID_DATA[:password])


end

Then(/^I should be denied access to the application$/) do
  expect(@app.login_screen.current_page?).to be true
end

Given (/^I enter proper credentials$/) do
  @app = page(DeskApp)
  @app.welcome_screen.await
  @app.welcome_screen.enter_sitename(VALID_USER[:sitename])
  if ENV['PLATFORM'] == 'ios'
    @app.login_screen.await
  end
  if ENV['PLATFORM'] == 'android'
    wait_for(:timeout => 10, :retry_frequency => 0.5, :post_timeout => 0.5, :timeout_message => 'Login screen not loaded') do
      @app.login_screen.current_page?
    end
  end
  @app.login_screen.enter_login_info(VALID_USER[:email], VALID_USER[:password])
  @app.case_filter_screen.await
end


Then (/^I log out of the app$/) do
  # noinspection RubyResolve
  if ENV['PLATFORM'] == 'ios'
    @app.case_filter_screen.find_menu_icon
    @app.case_filter_screen.await
    @app.case_filter_screen.touch_menu_icon
    @app.menu_screen.await
    @app.menu_screen.touch_logout
  end
  # noinspection RubyResolve
  if ENV['PLATFORM'] == 'android'
    @app.case_filter_screen.find_menu_icon
    @app.case_filter_screen.await
    sleep 1
    @app.case_filter_screen.touch_menu_icon
    sleep 1
    #not sure why the app randomly crashes on log out
    @app.case_filter_screen.touch_logout
    sleep 1
    @app.welcome_screen.await
    sleep 1
  end
end

