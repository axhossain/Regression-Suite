require 'calabash-cucumber/ibase'

# noinspection RubyResolve,RubyResolve
class CaseLabelScreen < Desk
  include DeskiOS::IOSHelpers

  attr_reader :new_value

  trait(:trait) {"navigationItemView marked:'Labels'"}

  element(:done_button) {"navigationButton marked:'Done'"}
  element(:replace_button) {"label marked:'Replace'"}
  element(:label_item) {'tableViewCellContentView'}
  element(:back_button) { "button marked:'BackArrowWhite'"}

  action(:touch_back_button) {touch(back_button)}
  action(:touch_done) {touch(done_button)}
  action(:touch_replace) {touch(replace_button)}

  def choose_random_label
    @new_value = randomize_selection(label_item)
    touch_done
    sleep 1
    touch_replace
  end

  def add_label(existing_labels)
    counter = 0
    wait_for(:timeout => 10) do
      text = query("tableViewCell index:#{counter} label", :text).first
      counter = counter + 1 if existing_labels.index(text) != nil
      @new_value = text if existing_labels.index(text) == nil
      existing_labels.index(text) == nil
    end

    touch("tableViewCell index:#{counter}")
    sleep 1
    touch_back_button
  end

  def remove_label(existing_labels)
    counter = 0
    wait_for(:timeout => 10) do
      text = query("tableViewCell index:#{counter} label", :text).first
      counter = counter + 1 if existing_labels.index(text) == nil
      @new_value = text if existing_labels.index(text) != nil
      existing_labels.index(text) != nil
    end
    touch("tableViewCell index:#{counter}")
    sleep 1
    touch_back_button
  end

  def verify_label(label, selected = true)
    selected_labels = query("view isSelected:1").map{ |label| label["text"] }
    expect(selected_labels.include?(label)).to be selected
  end
end
