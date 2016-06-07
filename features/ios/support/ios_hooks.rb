Before('@log') do
  `mv #{IOS_Sim_Log_Path}/system.log #{IOS_Sim_Log_Path}/system.log_backup` # Rename existing log file
end

After('@log') do |scenario|
  `cp #{IOS_Sim_Log_Path}/system.log results/logs/IOS_SIM_#{scenario.name.gsub(' ', '_')}.log` # make a copy of the log file
  `cat #{IOS_Sim_Log_Path}/system.log >> #{IOS_Sim_Log_Path}/system.log_backup` # cat the log file into only old file
  `rm #{IOS_Sim_Log_Path}/system.log` # delete temp log file
  `mv #{IOS_Sim_Log_Path}/system.log_backup #{IOS_Sim_Log_Path}/system.log` # Rename existing log file
end