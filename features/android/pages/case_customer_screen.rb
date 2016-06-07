require_relative '../../../features/android/droid_base'
require 'pry'

class CaseCustomerScreen < Desk
  include DeskAndroid::AndroidHelpers

  trait(:trait) {"* text:'Email (home)'"}
  element(:company_tab) {"* text:'Company'"}
  action(:touch_customer_tab) {touch(customer_tab)}
  action(:touch_company_tab) {touch(company_tab)}

  def verify_details(case_search)
    case case_search
      when 'Company Profile'
        check_element_exists("textView text:'Fighter'")
        check_element_exists("textView text:'Amzad Hossain'")
        check_element_exists("textView text:'Email (home)'")
        check_element_exists("textView text:'ahossain@desk.com'")
        check_element_exists("textView text:'Phone (home)'")
        check_element_exists("textView text:'111-222-3333'")
        check_element_exists("textView text:'Address (home)'")
        check_element_exists("textView text:'1760 Gentry St, WIchita, KS-67208'")

        scroll_down
        sleep 1
        check_element_exists("textView text:'Twitter'")
        check_element_exists("textView text:'@Amzad19'")
        # TODO  Uncomment after https://desk.atlassian.net/browse/MA-476
        # check_element_exists("textView text:'Title'")
        # check_element_exists("textView text:'Fighter'")
        check_element_exists("textView text:'Facebook'")
        check_element_exists("textView text:'Background'")
        check_element_exists("textView text:'Favorite Widget'")
        check_element_exists("textView text:'1092 - Blue'")

        scroll_down
        sleep 1
        check_element_exists("textView text:'Size of Company'")
        check_element_exists("textView text:'1234567890'")
        check_element_exists("textView text:'Contract Start Date'")
        check_element_exists("textView text:'Oct 8, 2014'")
        check_element_exists("textView text:'Salesname'")
        check_element_exists("textView text:'hello.desk'")
        check_element_exists("textView text:'Top 100?'")
        check_element_exists("textView text:'Yes'")
      else
        fail 'unknown case details'
    end
  end

end