# noinspection RubyResolve
require 'calabash-android/operations'
require "minitest/autorun"
require 'test/unit/assertions'


INSTALLATION_STATE = {
    :installed => true
}

Before do |scenario|
  scenario_tags = scenario.source_tag_names

  if scenario_tags.include?('@reinstall') || !INSTALLATION_STATE[:installed]
    uninstall_apps
    install_app(ENV['TEST_APP_PATH'])
    install_app(ENV['APP_PATH'])
    INSTALLATION_STATE[:installed] = true
  end

  # Current work around for HTTP Disconnect on :android logout
  clear_app_data if android?

  start_test_server_in_background

  page(DeskApp).eula_screen.accept_eula
end

# noinspection RubyUnusedLocalVariable
After do |scenario|
  shutdown_test_server
end

def android?
  ENV['PLATFORM'] == 'android'
end
