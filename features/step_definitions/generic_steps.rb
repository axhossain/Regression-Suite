Then /^I should be on the (\w+) screen$/ do |screen|
  case screen
    when 'welcome'.downcase
      sleep(5)
      expect(@app.welcome_screen.current_page?).to be true
    else
      fail('Unknown Screen')
  end
end

Given(/^I am signed into the application$/) do
  @app = page(DeskApp)
  #TODO Detect EULA screen and accept
  @app.welcome_screen.await
  @app.welcome_screen.enter_sitename(VALID_USER[:sitename])
  #TODO Detect what page app starts on and act correctly
  #TODO Detect OAUTH page and accept

  if ENV['PLATFORM'] == 'ios'
    @app.login_screen.await
    @app.login_screen.enter_login_info(VALID_USER[:email], VALID_USER[:password])
    @app.case_filter_screen.await

  # work around for weird issue where logging out doesn't really log out on android
  elsif ENV['PLATFORM'] == 'android'
    wait_for(:timeout => 10, :retry_frequency => 0.5, :post_timeout => 0.5, :timeout_message => 'Neither login screen or case filter screen or crash screen loaded') do
      @app.case_filter_screen.current_page? or @app.login_screen.current_page? or @app.crash_screen.current_page?
    end
    while @app.crash_screen.current_page?
      @app.crash_screen.touch_dismiss_button
      sleep 1
    end
    if @app.login_screen.current_page?
      @app.login_screen.await
      @app.login_screen.enter_login_info(VALID_USER[:email], VALID_USER[:password])
    end

    @app.case_filter_screen.touch_never_button

    wait_for(:timeout => 10, :retry_frequency => 0.5, :post_timeout => 0.5, :timeout_message => 'Neither filter screen or crash screen loaded') do
      @app.case_filter_screen.current_page? or @app.crash_screen.current_page?
    end
    while @app.crash_screen.current_page?
      @app.crash_screen.touch_dismiss_button
      sleep 1
    end
  end
end

Given /^I open the "(.*?)" filter$/ do |filter|
  @app.case_filter_screen.await
  # noinspection RubyResolve
  @app.case_filter_screen.touch_menu_icon if ENV['PLATFORM'] == 'ios'
  # noinspection RubyResolve
  @app.case_filter_screen.open_filter_window if ENV['PLATFORM'] == 'android'
  @app.menu_screen.await
  @app.menu_screen.change_filter(filter)
  @app.case_filter_screen.await
end

Then(/^I should see the cases belonging to the "(.*?)" filter$/) do |filter|
  @app.case_filter_screen.await
  expect(@app.case_filter_screen.current_filter).to be == filter
end

And (/^I create a "(.*?)" case using "(.*?)" resource$/) do |type,resource|
  ApiCall.api_call(type,resource)
end
