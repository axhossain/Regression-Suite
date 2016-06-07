require 'calabash-cucumber/ibase'

# noinspection RubyResolve,RubyResolve
class CaseCustomerScreen < Desk
  include DeskiOS::IOSHelpers

  trait(:trait) {"label marked:'Email (Home)'"}
  element(:customer_tab) {"segmentLabel marked:'Customer'"}
  element(:company_tab) {"view marked:'Company'"}
  action(:touch_customer_tab) {touch(customer_tab)}
  action(:touch_company_tab) {touch(company_tab)}

  def verify_details(case_search)
    wait_for_none_animating
    case case_search
      when 'Company Profile'
        check_element_exists("view marked:'Fighter at MI-693 Desk.com'")
        check_element_exists("view marked:'Email (Home)'")
        check_element_exists("view marked:'Amzad Hossain'")
        check_element_exists("view marked:'ahossain@desk.com'")
        check_element_exists("view marked:'Phone (Home)'")
        check_element_exists("view marked:'111-222-3333'")
        check_element_exists("view marked:'Address (Home)'")
        check_element_exists("view marked:'1760 Gentry St, WIchita, KS-67208'")
        check_element_exists("view marked:'Twitter'")
        check_element_exists("view marked:'Amzad19'")
        check_element_exists("view marked:'Title'")
        check_element_exists("view marked:'Fighter'")

        scroll 'tableView', :down
        sleep 1
        check_element_exists("view marked:'Size of Company'")
        check_element_exists("view marked:'1234567890'")
        check_element_exists("view marked:'Contract Start Date'")
        check_element_exists("view marked:'Oct 8, 2014'")
        check_element_exists("view marked:'Top 100?'")
        check_element_exists("view marked:'Yes'")
        check_element_exists("view marked:'Favorite Widget'")
        check_element_exists("view marked:'1092 - Blue'")
        check_element_exists("view marked:'Salesname'")
        check_element_exists("view marked:'hello.desk'")
      else
        fail 'unknown case details'
    end
  end

end