require_relative '../../../features/android/droid_base'
require 'pry'

class CaseCompanyScreen < Desk
  include DeskAndroid::AndroidHelpers

  trait(:trait) {"* text:'Domains'"}
  action(:touch_customer_tab) {touch(customer_tab)}
  action(:touch_company_tab) {touch(company_tab)}

  def verify_details(case_search)
    case case_search
      when 'Company Profile'
        check_element_exists("textView text:'MI-693 Desk.com'")
        check_element_exists("textView text:'Domains'")
        check_element_exists("textView text:'desk.com desk1.com desk2.com desk3.com desk4.com desk5.com '")
        check_element_exists("textView text:'503c'")
        check_element_exists("textView text:'Yes'")
        check_element_exists("textView text:'CEO'")
        check_element_exists("textView text:'CEO Number 1'")
        check_element_exists("textView text:'Dec 14, 2014'")
        check_element_exists("textView text:'Sep 27, 2014'")

        scroll_down
        sleep 1
        check_element_exists("textView text:'Region'")
        check_element_exists("textView text:'southwest'")
        check_element_exists("textView text:'2nd Address'")
        check_element_exists("textView text:'1777 Gentry ST, Wichita, KS-67208'")
        check_element_exists("textView text:'List # 4'")
        check_element_exists("textView text:'Number1'")
        check_element_exists("textView text:'9999999999'")
        check_element_exists("textView text:'Employees'")
        check_element_exists("textView text:'9999999999'")
        check_element_exists("textView text:'True False'")
        check_element_exists("textView text:'Yes'")
      else
        fail 'unknown case details'
    end
  end

end