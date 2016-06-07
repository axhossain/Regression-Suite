require 'calabash-cucumber/ibase'

# noinspection RubyResolve,RubyResolve
class CasePriorityScreen < Desk
  include DeskiOS::IOSHelpers

  attr_reader :new_value

  trait(:trait) {"label marked:'CASE PRIORITY:'"}

  element(:back_button) { "button marked:'BackArrowWhite'"}

  action(:touch_back_button) {touch(back_button)}

  def choose_random_priority (current_value)
    @new_value = randomize_slider(1,10,current_value)
    touch_back_button
  end

end