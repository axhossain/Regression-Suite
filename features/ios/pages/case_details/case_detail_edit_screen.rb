class CaseDetailEditScreen < CaseConversationScreen
  include DeskiOS::IOSHelpers

  attr_reader :new_value

  trait(:trait) {"view"}

  element(:choice) { 'tableView' }
  element(:boolean) { 'switch' }
  element(:editText) { 'textField' }
  element(:datePicker) { 'datePicker' }
  element(:done_button) { "button marked:'Done'" }

  action(:touch_done) {touch(done_button)}
  action(:touch_boolean) {touch(boolean)}

  def switch_opposite_boolean(current_value)
    wait_for_element_exists(boolean)
    touch boolean
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
    clear_text(editText)
    @new_value = enter_text_characters(editText, 12)
    touch_done
  end

  def enter_custom_field_number
    clear_text(editText)
    @new_value = enter_text_numbers(editText)
    touch_done
  end

  def choose_random_date (current_value)
    wait_for_element_exists(datePicker)
    @new_value = randomize_date_picker(current_value)
    touch_done
  end
end
