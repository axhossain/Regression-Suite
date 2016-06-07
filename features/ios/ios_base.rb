require_relative '../support/desk_base'

class Desk < Calabash::IBase
  include DeskBase

  def self.element(element_name, &block)
    define_method(element_name.to_s, &block)
  end

  # noinspection RubyResolve,RubyResolve,RubyResolve
  class << self
    alias :value :element
    alias :action :element
    alias :trait :element
  end
end
