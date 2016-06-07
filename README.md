Regression-Suite
================
This project is currently for use with the mobile-io & mobile-android projects.  Calabash & Cucumber are utilized.

In time we plan to integrate the main app (AA) cucumber suite here for one comprehensive test suite.

How to run the Test Suite
-------------------------

###iOS
``` bundle exec cucumber -p ios ```

###Android
``` bundle exec calabash-android run Desk.apk -p android ```

Reserved Tags
----------------

| Tag | Description| |
|---|---|---|
| @reinstall | This will remove the installed app, reinstall the app and relaunch the app.|
| @ios | Tests that only run on the ios platform. |
| @android | Tests that only run on the android platform. |
| @log  |Capture and save the debug log from device |
|  |**Platform** | **Log File** |
|  |Android   | ADB_{Scenario_Name}.log|
|  |IOS       | IOS_SIM_{Scenario_Name}.log |
| @no-logout | Framework will ***not*** logout the client when done with scenario|
  
Useful Links
----------------

* [Calabash main site](http://calaba.sh)
* Calabash [android](https://github.com/calabash/calabash-android) [ios](https://github.com/calabash/calabash-io) github repos
* Calabash [android](https://groups.google.com/forum/#!forum/calabash-android) [ios](https://groups.google.com/forum/#!forum/calabash-ios) discussion groups
