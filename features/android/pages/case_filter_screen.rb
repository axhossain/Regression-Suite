require 'byebug'

class CaseFilterScreen < Desk
  include DeskAndroid::AndroidHelpers

  attr_accessor :original_status, :num_selected

  trait(:trait) { "textView id:'subject'" }

  element(:individual_case_element) { "textView id:'subject'" }
  element(:menu_button) { "overFlowMenuButton" }
  element(:ignore_button) { "button text:'Ignore'" }
  element(:logout) {"textView text:'Logout'"}
  element(:search_all_cases_field) { "* id:'search' contentDescription:'Search cases'" }
  element(:no_cases) { "textView text:'No Cases'" }
  element(:search_results_list) { "listView" }
  element(:never_button) { "button text:'Never'" }

  action(:touch_logout) { touch(logout) }
  action(:touch_menu_icon) { press_menu_button }
  action(:touch_ignore_button) {touch(ignore_button)}
  action(:open_filter_window) { touch ("imageView id:'up'") }
  action(:touch_search) { touch(search_all_cases_field) }

  def find_menu_icon
    wait_poll(:until_exists => menu_button, :timeout => 10, :retry_frequency => 1, :post_timeout => 1, :timeout_message => "Couldn't find the Menu button") do
      if element_exists(ignore_button)
        touch_ignore_button
        sleep 1
      else
        press_back_button
        sleep 1
      end
    end
  end

  def current_filter
    query('TextView id:"action_bar_title"')[0]['text'].gsub(/ \(\d+\)/, '').rstrip
  end

  def touch_a_case
    @prev_selected_case_subj = randomize_selection(individual_case_element, 0)
  end

  def touch_a_label_case(label_check)
    query = "linearLayout id:'linear_layout2'"
    #ignore the last item in the list in case the labels are off view
    total_options = query(query).length.to_i - 1
    done = false
    idx = 0;
    begin
      query_string = "linearLayout id:'linear_layout2' index:#{idx}"
      label_query_string = query_string + " descendant horizontalScrollView"
      idx = idx + 1
      if idx >= total_options
        scroll_down
        total_options = query(query).length.to_i
        idx = 0
      end
      done = (query(label_query_string).length == label_check.to_i)
    end until done

    touch(query_string)
    sleep 1
  end

  def open_case(subject)
    subject = subject.gsub("'"){"\\'"}
    query_string = "textView id:'subject' text:'#{subject}'"
    wait_for_element_exists(query_string)
    touch(query_string)
  end

  def open_prev_case
    prev_subject = @prev_selected_case_subj.gsub("'"){"\\'"}
    prev_case_element = "textView id:'subject' text:'#{prev_subject}'"
    wait_for_element_exists(prev_case_element)
    touch(prev_case_element)
  end

  def open_first_case
    wait_for_element_exists(individual_case_element)
    first_element = query(individual_case_element).first
    touch(first_element)
  end

  def find_status(index=1)
    query_string = "imageView id:'case_status' index:#{index}"
    status = query(query_string, :contentDescription).first
    status
  end

  def open_case_not_status(status)
    query_string = "imageView id:'case_status'"
    total = query(query_string).length - 1
    counter = 0
    found = false
    current_screen_state = query('*')
    prev_screen_state = []
    while (!found && current_screen_state != prev_screen_state)
      latest_query = "imageView id:'case_status' index:#{counter}"
      found = (query(latest_query, :contentDescription).first != status.downcase)
      counter = counter + 1;
      if (counter >= total)
        prev_screen_state = current_screen_state
        scroll_down
        counter = 0
        total = query(query_string).length - 1
        current_screen_state = query('*')
      end
    end

    if !found
      fail("No case found that is not #{status}")
    else
      touch(latest_query)
    end
  end

  def open_case_status(status)
    query_string = "imageView id:'case_status' contentDescription:'#{status.downcase}'"
    touch_in_list(query_string)
  end

  def search(text)
    touch_search
    sleep 1
    keyboard_enter_text(text)
    hit_enter_key
  end

  def number_of_items(comparator, number)
    number = number.to_i
    if !comparator && number == 0
      wait_for_element_exists(no_cases)
      check_element_exists(no_cases)
    else
      num_rows = search_results_rows
      if !comparator and num_rows != number
        fail_with_expected_actual(number, num_rows)
      elsif comparator == 'at least' and num_rows < number
        fail_with_expected_actual(number, num_rows)
      end
    end
  end

  def search_results_rows
    wait_for_element_exists(search_results_list)
    query(search_results_list, :adapter, :count).first
  end

  def fail_with_expected_actual(expected, actual)
    fail('Expected #{expected} but got #{actual}')
  end

  def touch_never_button
    touch(never_button) if never_button?
  end

  def never_button?
    sleep 1
    element_exists(never_button)
  end
end
