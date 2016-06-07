# noinspection RubyResolve
require 'calabash-cucumber/ibase'
require 'pry'

# noinspection RubyResolve,RubyResolve
class CaseFilterScreen < Desk
  include DeskiOS::IOSHelpers

  attr_accessor :original_status, :num_selected

  trait(:trait) { "button marked:'Menu'" }

  element(:menu_icon) { "button marked:'Menu'" }
  element(:back_button) { "button marked:'BackArrowWhite'"}
  element(:cancel_button) { "button marked:'Cancel'"}
  element(:discard_button) { "label marked:'Discard Changes'"}

  element(:search_bar) { 'searchBar' }
  element(:individual_case_element) { 'tableViewCellContentView' }
  element(:filter_name) { 'UINavigationItemView' }
  element(:edit_button) {"button marked:'Edit'"}
  element(:not_selected) {"view id:'BulkEditDeselected'"}
  element(:selected) {"view id:'CheckmarkSelected'"}
  element(:bulk_assign) {"imageView marked:'BulkAssign'"}
  element(:bulk_status) {"imageView marked:'BulkStatus'"}
  element(:bulk_label) {"imageView marked:'BulkLabel'"}
  element(:no_cases) {"label marked:'No Results'"}
  element(:search_results_table) {"searchResultsTableView"}

  action(:touch_bulk_assign) {touch(bulk_assign)}
  action(:touch_bulk_status) {touch(bulk_status)}
  action(:touch_bulk_label) {touch(bulk_label)}
  action(:touch_not_selected) {touch(not_selected)}
  action(:touch_edit_button) {touch(edit_button)}
  action(:touch_menu_icon) { touch(menu_icon) }
  action(:touch_back_button) { touch(back_button) }
  action(:touch_cancel_button) { touch(cancel_button) }
  action(:touch_discard_button) { touch(discard_button) }

  def find_menu_icon
    wait_poll(:until_exists => menu_icon, :timeout => 10, :retry_frequency => 0.3, :post_timeout => 0.3, :timeout_message => "Couldn't find the Menu button") do
      if element_exists(discard_button)
        touch_discard_button
      end
      if element_exists(back_button)
        touch_back_button
      end
      if element_exists(cancel_button)
        touch_cancel_button
      end
    end
  end

  def touch_a_case
    randomize_selection(individual_case_element, 1)
  end

  def open_case(subject)
    query_string = "label marked:'#{subject}'"
    wait_for_elements_exist([query_string])
    touch(query_string)
  end

  def current_filter
    query('UINavigationBar')[1]['id'].gsub(/ \(\d+\)/, '').rstrip
  end

  def wait_for_bulk_edit
    touch_edit_button
    wait_for_none_animating
    wait_for_elements_exist([not_selected])
  end

  def select_all_items_in_view
    @num_selected = 0
    while element_exists(not_selected) do
      @num_selected = @num_selected + 1
      touch_not_selected
    end
  end

  def wait_timestamp_change (index=1)
    query_string = "tableViewCellContentView index:#{index} child view index:3"
    current = query(query_string, :text).first
    wait_for(:timeout => 30, :retry_frequency => 0.5, :post_timeout => 1, :timeout_message => "Timed out waiting for case timestamp to change") do
      current != query(query_string, :text).first
    end
  end

  def find_status(index=1)
    wait_for_none_animating
    query_string = "tableViewCellContentView index:#{index} imageView"
    imageViews = query_map(query_string, :id)
    status_index = imageViews.index{|s| s.include? 'status-' unless s.nil?}
    status = imageViews[status_index].split('-')[1] unless status_index.nil?
    status
  end

  def get_status (index=1)
    @original_status = self.find_status(index)
  end

  def wait_status_change (index=1)
    wait_for(:timeout => 30, :retry_frequency => 0.5, :post_timeout => 1, :timeout_message => "Status did not change") do
      @original_status != self.find_status(index)
    end
    wait_for_none_animating
  end

  #Needs to be improved once labels get an id
  def wait_label_change (label)
    wait_for_elements_exist(["view marked:'#{label}'"])
    sleep 1
  end

  def verify_status (status)
    count = query("tableViewCellContentView").length.to_i - 1 # because last cell is sometimes not completely in view
    for i in 0...count
      check_element_exists("tableViewCellContentView index:#{i} imageView id:'status-#{status.downcase}'")
    end
  end

  def verify_label (label)
    count = query("tableViewCellContentView").length.to_i - 1 # because last cell is sometimes not completely in view
    for i in 0...count
      check_element_exists("tableViewCellContentView index:#{i} label marked:'#{label}'")
    end
  end

  def open_case_not_status(status)
    row = 0
    scroll_increment = 4
    found = false
    wait_for_none_animating
    wait_for(:timeout => 30, :retry_frequency => 1) do
      # This is because after scrolling, row 0 is not in view
      if row == 0
        @counter = -1
      else
        @counter = 0
      end
      # the -1 is because the last row might not completely be in view
      total = query('tableViewCell').length - 1
      while found == false && @counter < total
        @counter = @counter + 1
        found = self.find_status(@counter) != status.downcase
      end
      if found != true
        row = row + scroll_increment
        scroll_to_row('tableView', row)
      end
      found
    end
    touch("tableViewCell index:#{@counter}")
  end

  def search(text)
    send_uia_command :command => "target.frontMostApp().mainWindow().tableViews()[0].scrollUp()"
    sleep 1
    wait_for_none_animating
    enter_text('textField', text)
    keyboard_enter_char 'Return'
  end

  def number_of_items(comparator, number)
    number = number.to_i

    if !comparator && number == 0
      wait_for_element_exists(no_cases)
      check_element_exists(no_cases)
    else
      wait_for_element_exists(search_results_table)
      num_rows = search_results_rows
      #TODO replace this with an 'expect' once we figure out why assertions aren't working in iOS 8
      if !comparator and num_rows != number
        fail_with_expected_actual(number, num_rows)
      elsif comparator == 'at least' and num_rows < number
        fail_with_expected_actual(number, num_rows)
      end
    end
  end

  def search_results_rows
    query(search_results_table, numberOfRowsInSection:0).first
  end

  def fail_with_expected_actual(expected, actual)
    fail('Expected #{expected} but got #{actual}')
  end

end