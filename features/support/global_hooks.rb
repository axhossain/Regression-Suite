After('~@no-logout') do
  # See launch_hooks for details
  if ios?
    step 'I log out of the app'
  end
end

def ios?
  ENV['PLATFORM'] == 'ios'
end
