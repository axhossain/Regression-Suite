require 'calabash-cucumber/ibase'

# noinspection RubyResolve,RubyResolve
class CaseCompanyScreen < Desk
  include DeskiOS::IOSHelpers

  trait(:trait) {"label marked:'Domains'"}
  element(:customer_tab) {"segmentLabel marked:'Customer'"}
  element(:company_tab) {"segmentLabel marked:'Company'"}
  action(:touch_customer_tab) {touch(customer_tab)}
  action(:touch_company_tab) {touch(company_tab)}

  def verify_details(case_search)
    wait_for_none_animating
    case case_search
      when 'Company Profile'
        check_element_exists("view marked:'MI-693 Desk.com'")
        check_element_exists("view marked:'Domains'")
        check_element_exists("view marked:'desk.com, desk1.com, desk2.com, desk3.com, desk4.com, desk5.com'")
        check_element_exists("view marked:'2nd Address'")
        check_element_exists("view marked:'1777 Gentry ST, Wichita, KS-67208'")
        check_element_exists("view marked:'503c'")
        check_element_exists("view marked:'Yes'")
        check_element_exists("view marked:'CEO'")
        check_element_exists("view marked:'CEO Number 1'")
        check_element_exists("view marked:'Sep 27, 2014'")
        check_element_exists("view marked:'9999999999'")
        check_element_exists("view marked:'Dec 14, 2014'")
        check_element_exists("view marked:'List # 4'")

        scroll 'tableView', :down
        sleep 1
        check_element_exists("view marked:'Number1'")
        check_element_exists("view marked:'9999999999'")
        check_element_exists("view marked:'Region'")
        check_element_exists("view marked:'southwest'")
        check_element_exists("view marked:'True False'")
        check_element_exists("view marked:'Yes'")
      else
        fail 'unknown case details'
    end
  end

end