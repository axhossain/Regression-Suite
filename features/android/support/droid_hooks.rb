After('@log') do |scenario|
  system("adb logcat -d  > results/logs/ADB_Log_#{scenario.name.gsub(' ', '_')}.log")
end