# noinspection RubyResolve
require 'calabash-cucumber/ibase'

class MenuScreen < Desk
  include DeskiOS::IOSHelpers

  trait(:trait) { "label marked:'CASE FILTERS'" }

  element(:logout) { "button marked:'Logout'" }
  element(:feedback) { "button marked:'Feedbackicon'" }

  def touch_logout
    touch(logout)
  end

  def change_filter(filter_name)
    scroll_to_row('tableView', 0)
    sleep(1)
    wait_poll(:until_exists => "UILabel text:'#{filter_name}'") do
      scroll('tableView', :down)
    end

    touch("UILabel text:'#{filter_name}'")
  end

end