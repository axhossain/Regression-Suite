class MenuScreen < Desk
  include DeskAndroid::AndroidHelpers

  trait(:trait) { "listView id:'left_drawer' textView index:0" }

  def change_filter(filter_name)
    touch_in_list("TextView text:'#{filter_name}'", 1)
  end

end