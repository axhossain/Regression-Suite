require 'calabash-cucumber/ibase'
require_relative '../../../support/desk_base'
require 'byebug'

# noinspection RubyResolve,RubyResolve
class CaseDetailsScreen < CaseConversationScreen
  include DeskiOS::IOSHelpers

  attr_reader :original_value

  trait(:trait) { 'view' }

  element(:item) { 'tableViewCellContentView' }

  def verify_downloaded_content(file_size,attachment_name,file_size_status)
    case file_size
      when 'small'
        sleep(5)
      when 'medium'
        sleep(10)
      when 'big'
        sleep(20)
    end
    verify_text = query("label {text CONTAINS 'Downloaded'}", :text).first
    if file_size_status == verify_text
      query = ("label {text CONTAINS 'Downloaded'}")
      touch(query)
      case attachment_name
        when 'Attachment AppDelegate.h','Attachment AppDelegate.m','Attachment D01HelloiPhone-Info.plist',
            'Attachment CMA_Android_P2P-V4.0.0.0-287-Universal-09901-Debug.apk','Attachment D01HelloiPhone-Prefix.pch',
            'Attachment main.m','Attachment Test_Cases_steps.xls'
          sleep 3
          query = ("label {text CONTAINS 'Cancel'}")
          touch(query)
        when 'Attachment cbs2HealthCheck.pl','Attachment droidAtScreen-1.0.2.jar','Attachment Demo.mov',
            'Attachment fsg_health_check.rb','Attachment IMG_3245.JPG','Attachment MACKLEMORE___RYAN_LEWIS.mp3',
            'Attachment mw_automation_notes.rtf','Attachment reports_android.html','Attachment simple_test.zip',
            'Attachment DBSync Tool Tech Spec sections.doc'
          sleep 3
          query = ("UIButtonLabel text:'Done'")
          touch(query)
      end
    end
  end

  def verify_group(group)
    verify_table_view_detail('Group', group)
  end

  def verify_agent(agent)
    verify_table_view_detail('Agent', agent)
  end

  def verify_table_view_detail(field, value)
    verify_detail(field, value, 'UITableViewLabel')
  end

  def verify_detail(field, value, view_type = 'view')
    sibling_view_type = view_type

    case field
    when 'Agent'
      query = ("label {text CONTAINS '#{field}'}")
    when 'Label'
      sibling_view_type = 'label'
    when 'Status', 'Priority'
      view_type = 'label'
      sibling_view_type = view_type
    when *custom_field_types
      field = custom_field_by_type(field)
      if field == 'Widget Date'
        value = DateTime.parse(value).strftime(NON_PADDED_DISPLAY_DATE_FORMAT)
      end
    end

    query_string = "#{view_type} marked:'#{field}' sibling #{sibling_view_type} marked:'#{value}'"

    wait_for_element_exists(query_string)
    check_element_exists(query_string)
  end

  def verify_label_change(action, original, new)
    case action
    when 'added'
      original.each {|s| wait_for_element_exists(["label marked:'#{s}'"])}
      check_element_exists("label marked:'#{new}'")
    when 'removed'
      original = original - [new]
      original.each {|s| wait_for_element_exists(["label marked:'#{s}'"])}
      check_element_does_not_exist("label marked:'#{new}'")
    else
      fail 'Unknown label action'
    end
  end

  def get_value(field)
    value = case field
            when 'Label'
              query("tableViewCell index:5 label", :text)
            when *custom_field_types
              custom_field_value_by_type(field)
            else
              query("view marked:'#{field}' sibling label", :text).first
            end

    value
  end

  def custom_field_value_by_type(type)
    value = nil
    retry_frequency = 0.5

    text = custom_field_by_type(type)
    element_query = "view marked:'#{text}'"

    wait_for_none_animating

    wait_poll(until_exists: element_query, retry_frequency: retry_frequency) do
      scroll('tableView', :down)
    end

    value_query = "#{element_query} sibling label"

    text_value_by_query_string value_query
  end

  def text_value_by_query_string(query_string)
    query(query_string, :text).first
  end

  def enter_edit_labels
    mode = 'Label'
    mode = mode.ucase.pluralize if ENV['PLATFORM'] == 'android'
    enter_edit_mode(mode)
  end

  def enter_edit_mode(field)
    @original_value = get_value(field)

    case field
    when 'Label'
      query_string = "tableViewCell index:5 imageView"
    when *custom_field_types
      # TODO:  DRY things up by making use of custom_field_value_by_type
      text = custom_field_by_type(field)
      query_string = "view marked:'#{text}'"
    else
      query_string = "view marked:'#{field}'"
    end

    wait_for_element_exists(query_string)
    touch query_string
  end

  def wait_value_change(field)
    wait_for(:timeout => 30, :retry_frequency => 0.5, :post_timeout => 0.3) do
      new_value = get_value(field)
      new_value != original_value
    end
  end

  def verify_details(case_search)
    wait_for_none_animating
    case case_search
      when 'Case Details'
        scroll 'tableView', :down
        sleep 1
        check_element_exists("view marked:'Custom Text'")
        check_element_exists("view marked:'~!@\#$%^&*())_+{}|:\"<>?'")
        check_element_exists("view marked:'MA363Text'")
        check_element_exists("view marked:'qwertyuioplkjhgfdsazxcvbnm1234567890'")
        check_element_exists("view marked:'Widget Color'")
        check_element_exists("view marked:'Red Blue Green Yellow Indigo Violet'")
        check_element_exists("view marked:'Widget Date'")
        check_element_exists("view marked:'Nov 30, 2035'")
        check_element_exists("view marked:'Widget Expired'")
        check_element_exists("view marked:'Yes'")
        check_element_exists("view marked:'Widget Number'")
        check_element_exists("view marked:'9999999999'")
        check_element_exists("view marked:'Widget Type'")
        check_element_exists("view marked:'Custom'")
      else
        fail 'unknown case details'
    end
  end
end
