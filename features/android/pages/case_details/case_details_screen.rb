# noinspection RubyResolve,RubyResolve
class CaseDetailsScreen < CaseConversationScreen
  include DeskAndroid::AndroidHelpers

  attr_reader :original_value

  trait(:trait) {"textView text:'LABELS'"}

  element(:labels_scroll) {"horizontalScrollView id:'horizontal_scroll'"}

  def verify_detail(field, value)
    case field
      when 'Boolean', 'List', 'Text', 'Number', 'Date'
        query_string = "textView text:'#{CASE_CUSTOM_FIELDS[field]}' sibling textView text:'#{value}'"
      else
        element = "textView text:'#{field}'"
        scroll_down if !element_exists(element)
        query_string = element + " sibling textView text:'#{value}'"
    end
    wait_for_element_exists(query_string)
  end

  def verify_label_change(action, original, new)
    case action
      when 'added'
        wait_for_element_exists("horizontalScrollView descendant textView text:'#{new}'")
      when 'removed'
        original = original - [new]
        original.each {|s| wait_for_element_exists("horizontalScrollView descendant textView text:'#{s}'")}
        check_element_does_not_exist("horizontalScrollView descendant textView text:'#{new}'")
      else
        fail 'Unknown label action'
    end
  end

  def get_value(field)
    case field
      when 'LABELS'
        labels = query("horizontalScrollView descendant textView", :text)
      when 'Boolean', 'List', 'Date', 'Text', 'Number'
        value = query("textView text:'#{CASE_CUSTOM_FIELDS[field]}' sibling textView", :text).first
      else
        value = query("textView text:'#{field}' sibling textView",:text).first
    end
  end

  def enter_edit_mode(field)
    case field
      when 'Boolean', 'List', 'Date', 'Text', 'Number'
        scroll_down
        sleep 1
        @original_value = self.get_value(field)
        query_string = "textView text:'#{CASE_CUSTOM_FIELDS[field]}'"
        wait_for_element_exists(query_string)
        touch(query_string)
      else
        element = "textView text:'#{field}'"
        scroll_down if !element_exists(element)
        sleep 1
        @original_value = self.get_value(field)
        touch(element)
    end
  end

  def wait_value_change(field)
    wait_for(:timeout => 30, :retry_frequency => 0.5, :post_timeout => 0.3) do
      new_value = self.get_value(field)
      new_value != @original_value
    end
  end

  def verify_details(case_search)
    case case_search
      when 'Case Details'
        scroll_down
        check_element_exists("textView text:'Red Blue Green Yellow Indigo Violet'")
        check_element_exists("textView text:'~!@\#$%^&*())_+{}|:\"<>?'")
        check_element_exists("textView text:'MA363Text'")
        check_element_exists("textView text:'qwertyuioplkjhgfdsazxcvbnm1234567890'")
        check_element_exists("textView text:'Widget Color'")
        check_element_exists("textView text:'Red Blue Green Yellow Indigo Violet'")
        check_element_exists("textView text:'Widget Date'")
        check_element_exists("textView text:'Nov 30, 2035'")
        check_element_exists("textView text:'Widget Expired'")
        check_element_exists("textView text:'Yes'")
        check_element_exists("textView text:'Widget Number'")
        check_element_exists("textView text:'9999999999'")
        check_element_exists("textView text:'Widget Type'")
        check_element_exists("textView text:'Custom'")
      else
        fail 'unknown case details'
    end
  end

  def check_unassigned_group
    wait_for_element_exists("textView text:'Group' sibling textView text:'Unassigned'")
  end
end
