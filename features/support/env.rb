require_relative 'fixtures.rb'

case ENV['PLATFORM'].downcase
  when 'ios'
    #              ██╗ ██████╗ ███████╗
    #              ██║██╔═══██╗██╔════╝
    #              ██║██║   ██║███████╗
    #              ██║██║   ██║╚════██║
    #              ██║╚██████╔╝███████║
    #              ╚═╝ ╚═════╝ ╚══════╝
    # noinspection RubyResolve
    require 'calabash-cucumber/cucumber'
    # noinspection RubyResolve
    require 'calabash-cucumber/ibase'
    # noinspection RubyConstantNamingConvention
    IOS_Sim_Version = '7.1'
    # noinspection RubyConstantNamingConvention
    IOS_Sim_Log_Path = "~/Library/Logs/iOS\\ Simulator/#{IOS_Sim_Version}"


  when 'android'
    #              █████╗ ███╗   ██╗██████╗ ██████╗  ██████╗ ██╗██████╗
    #             ██╔══██╗████╗  ██║██╔══██╗██╔══██╗██╔═══██╗██║██╔══██╗
    #             ███████║██╔██╗ ██║██║  ██║██████╔╝██║   ██║██║██║  ██║
    #             ██╔══██║██║╚██╗██║██║  ██║██╔══██╗██║   ██║██║██║  ██║
    #             ██║  ██║██║ ╚████║██████╔╝██║  ██║╚██████╔╝██║██████╔╝
    #             ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝╚═════╝
    # noinspection RubyResolve
    require 'calabash-android/cucumber'
    # noinspection RubyResolve
    require 'calabash-android/abase'
  else
    fail('Unknown platform specified')
end
