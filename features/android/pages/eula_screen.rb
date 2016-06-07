require 'byebug'

class EulaScreen < Desk
  include DeskAndroid::AndroidHelpers

  trait(:trait) { accept_button }

  element(:accept_button) { "textView text:'ACCEPT'" }

  def accept_eula
    touch accept_button
  end
end
