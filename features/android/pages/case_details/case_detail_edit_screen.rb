class CaseDetailEditScreen < Desk
  include DeskAndroid::AndroidHelpers

  attr_reader :group, :agent, :new_value

  trait(:trait) {"dialogTitle id:'alertTitle'"}

  element(:choice) { 'checkedTextView' }
  element(:boolean) { 'switch' }
  element(:datePicker) { 'datePicker'}
  element(:editText) { 'editText' }
  element(:done_button) {"button text:'OK'"}
  element(:unassigned_label) {"checkedTextView text:'Unassigned'"}
  element(:community_answers) {'switch'}

  action(:touch_done) {touch(done_button)}
  action(:touch_boolean) {touch(boolean)}
  action(:touch_unassigned_label) {touch(unassigned_label)}

  def choose_random_group (forbidden_value = 'undefined')
    wait_for_elements_exist([choice])
    @group = randomize_selection(choice, 0, forbidden_value)
    @new_value = @group
    touch_done
  end

  def choose_random_agent (forbidden_value = 'undefined')
    wait_for_elements_exist([choice])
    @agent = randomize_selection(choice,0, forbidden_value)
    @new_value = @agent
    touch_done
  end

  def choose_unassigned_group
    wait_for_elements_exist([choice])
    wait_for_element_exists(unassigned_label)
    touch_unassigned_label
    touch_done
  end

  def check_agent_public_name
    f = Fixtures.new
    wait_for_element_exists("checkedTextView text:'#{f.agent_1['name']}'")
    check_element_does_not_exist("checkedTextView text:'#{f.agent_1['public_name']}'")
  end

  def choose_random_priority (current_value)
    @new_value = randomize_picker(1,10,current_value)
    touch_done
  end

  def choose_random_status (current_value)
    wait_for_elements_exist([choice])
    @new_value = randomize_selection(choice,0,current_value.capitalize)
    touch_done
  end

  def switch_opposite_boolean (current_value)
    wait_for_elements_exist([boolean])
    touch boolean
    @new_value = (current_value == 'Yes') ? 'No' : 'Yes'
    touch_done
  end

  def choose_opposite_community (current_value)
    wait_for_elements_exist([community_answers])
    touch community_answers
    @new_value = (current_value == 'Yes') ? 'No' : 'Yes'
    touch_done
  end

  def choose_random_list_item (current_value)
    wait_for_elements_exist([choice])
    forbidden = (current_value == nil)? "" :current_value.capitalize
    @new_value = randomize_selection(choice,0,forbidden)
    touch_done
  end

  def enter_custom_field_text
    clear_text_in(editText)
    @new_value = enter_text_characters(editText, 12)
    touch_done
  end

  def enter_custom_field_number
    clear_text_in(editText)
    @new_value = enter_text_numbers(editText)
    touch_done
  end

  def choose_random_date (current_value)
    wait_for_element_exists(datePicker)
    @new_value = randomize_date_picker(current_value)
    touch_done
  end

  def add_label (existing_labels)
    counter = 0
    @new_value = query("checkedTextView index:#{counter}", :text).first
    touch("checkedTextView index:#{counter}")
    sleep 1
    touch_done
  end

  def remove_label (existing_label)
    element = "checkedTextView"
    counter = 0
    done = false
    len = query(element).length.to_i - 1
    while !done
      new_query = "checkedTextView index:#{counter}"
      text = query(new_query, :text).first
      done = existing_label.index(text)
      counter = counter + 1
      if (counter >= len)
        scroll_down
        counter = 0;
        len = query(element).length.to_i - 1
      end
    end
    touch(new_query)
    sleep 1
    touch_done


  end
end
