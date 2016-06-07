require 'calabash-cucumber/ibase'

# noinspection RubyResolve,RubyResolve
class CaseStatusScreen < Desk
  include DeskiOS::IOSHelpers

  attr_reader :new_value

  trait(:trait) {"label marked:'Open'"}

  element(:done_button) {"navigationButton marked:'Done'"}
  element(:status_item) {'tableViewCellContentView'}
  element(:back_button) { "button marked:'BackArrowWhite'"}

  action(:touch_back_button) {touch(back_button)}
  action(:touch_agent_tab) {touch(agent_tab)}
  action(:touch_done) {touch(done_button)}

  def choose_random_status (current_value)
    @new_value = randomize_selection(status_item,0,current_value.capitalize)
    # different confirm action between bulk and not bulk edits
    if element_exists(back_button)
      touch_back_button
    else
      touch_done
    end
  end
end