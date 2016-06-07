# noinspection RubyResolve
require 'calabash-cucumber/ibase'
require_relative '../../../features/ios/ios_base'

class DeskApp < Desk

  def welcome_screen
    @welcome_screen ||= page(WelcomeScreen)
  end

  def login_screen
    @login_screen ||= page(LoginScreen)
  end

  def case_filter_screen
    @case_filter_screen ||= page(CaseFilterScreen)
  end

  def menu_screen
    @menu_screen ||= page(MenuScreen)
  end

  def case_assign_screen
    @case_assign_screen ||= page(CaseAssignScreen)
  end

  def case_conversation_screen
    @case_conversation_screen ||= page(CaseConversationScreen)
  end

  def case_details_screen
    @case_details_screen ||= page(CaseDetailsScreen)
  end

  def case_status_screen
    @case_status_screen ||=page(CaseStatusScreen)
  end

  def case_label_screen
    @case_label_screen ||=page(CaseLabelScreen)
  end

  def case_priority_screen
    @case_priority_screen ||=page(CasePriorityScreen)
  end

  def case_macro_screen
    @case_macro_screen ||=page(CaseMacroScreen)
  end

  def case_customer_screen
    @case_customer_screen ||=page(CaseCustomerScreen)
  end

  def case_company_screen
    @case_company_screen ||=page(CaseCompanyScreen)
  end

  def case_custom_field_screen
    @case_custom_field_screen ||=page(CaseDetailEditScreen)
  end

  def case_reply_screen
    @case_reply_screen ||=page(CaseReplyScreen)
  end

end

