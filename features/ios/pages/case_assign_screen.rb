require 'calabash-cucumber/ibase'
require 'byebug'

# noinspection RubyResolve,RubyResolve
class CaseAssignScreen < Desk
  include DeskiOS::IOSHelpers

  attr_reader :group, :agent, :new_value

  trait(:trait) {'tableViewCellContentView'}

  element(:group_tab) { "DSSegmentedControl label text:'Group'" }
  element(:agent_tab) { "DSSegmentedControl label text:'Agent'" }
  element(:select_agent) {"label {text CONTAINS 'Agent'}"}
  element(:assignee_choice) { 'tableViewCellContentView' }
  element(:done_button) {"navigationButton marked:'Done'"}
  element(:back_button) { "button marked:'BackArrowWhite'"}
  element(:unassigned_label) { "label marked:'Unassigned'"}

  action(:touch_back_button) {touch(back_button)}
  action(:touch_select_agent) {touch(select_agent)}
  action(:touch_agent_tab) {touch(agent_tab)}
  action(:touch_group_tab) {touch(group_tab)}
  action(:touch_done) {touch(done_button)}
  action(:touch_unassigned_label) {touch(unassigned_label)}

  def choose_random_group_and_agent
    choose_random_group
    choose_random_agent
    touch_done
  end

  def choose_random_group (forbidden_value = 'undefined')
    #different action depending on bulk or not bulk
    if element_exists(group_tab)
      touch_group_tab
    end

    wait_for_elements_exist([ assignee_choice ])

    if forbidden_value != 'undefined'
      @group = randomize_selection(assignee_choice, 1, forbidden_value)
    else
      @group = randomize_selection(assignee_choice, 1)
    end

    #different action depending on bulk or not bulk
    if element_exists(back_button)
      touch_back_button
    end

    @new_value = @group
  end

  def choose_random_agent (forbidden_value = 'undefined')
    #different action depending on bulk or not bulk
    if element_exists(agent_tab)
      touch_agent_tab
    end

    wait_for_elements_exist([assignee_choice])

    if forbidden_value != 'undefined'
      @agent = randomize_selection(assignee_choice,1,forbidden_value)
    else
      @agent = randomize_selection(assignee_choice,1)
    end
    #different action depending on bulk or not bulk
    if element_exists(back_button)
      touch_back_button
    end

    @new_value = @agent
  end

  def choose_unassigned_group
    wait_for_element_exists(unassigned_label)
    touch_unassigned_label
    touch_back_button
  end

  def check_agent_public_name
    f = Fixtures.new
    wait_for_element_exists("label marked:'#{f.agent_1['name']}'")
    check_element_does_not_exist("label marked:'#{f.agent_1['public_name']}'")
  end

  def choose_me_agent(agent_name)
    if element_exists(select_agent)
      touch_select_agent
    end
    wait_for_element_exists("label {text CONTAINS '#{agent_name}'}")
    @agent=("label {text CONTAINS '#{agent_name}'}")
    touch(@agent)
    if element_exists(back_button)
      touch_back_button
    end
    @new_value = agent_name
  end
end
