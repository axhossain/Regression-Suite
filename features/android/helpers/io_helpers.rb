# noinspection RubyResolve

module DeskAndroid

  module AndroidHelpers

    def touch_in_list(query, list_index = 0)
      sleep 1
      self.find_in_list(query, list_index)
      touch(query)
      sleep 1
    end

    def enter_text_date(field, text=Time.now.strftime("%b %d, %Y %H:%M"))
      enter_text(field, text )
      sleep 1
      text
    end

    def enter_text_characters(field, count=50)
      words = RandomEnglishWordsGenerator.new
      text = words.characters(count)
      enter_text(field,text)
      sleep 1
      text
    end

    def enter_text_numbers(field, count=999999999999999)
      numbers = rand(1..count)
      enter_text(field,numbers)
      sleep 1
      numbers
    end

    def randomize_selection(query, min_index = 0,forbidden_value = 'undefined')
      query_string = query.to_s
      total_options = query(query_string).length.to_i

      selected_option = Random.rand(min_index...total_options)
      choice_query_string = query_string + ' ' + "index:#{selected_option}"
      choice_string = query(choice_query_string,:text).first

      if forbidden_value != 'undefined'
        wait_for(:timeout => 5, :timeout_message => "Failed to find a valid match") do
          selected_option = Random.rand(min_index...total_options)
          choice_query_string = query_string + ' ' + "index:#{selected_option}"
          choice_string = query(choice_query_string,:text).first
          forbidden_value != choice_string
        end
      end

      touch(choice_query_string)
      sleep 1
      choice_string
    end

    def randomize_picker(min_value=0, max_value=10, forbidden_value='undefined', picker_index=0)
      new_value = Random.rand(min_value..max_value).to_i
      if forbidden_value != 'undefined'
        wait_for(:timeout => 5) do
          new_value = Random.rand(min_value..max_value).to_i
          new_value != forbidden_value.to_i
        end
      end
      query("numberPicker index:#{picker_index}", :setValue => new_value)
      sleep 1
      new_value
    end

    def randomize_date_picker(forbidden_date)
      new_date = Date.today-rand(10000)
      if forbidden_date
        date = Date.parse(forbidden_date)
        wait_for(:timeout => 5) do
          new_date = Date.today-rand(10000)
          new_date != date
        end
      end
      new_year = new_date.year
      new_month = new_date.mon-1
      new_day = new_date.mday
      query("datePicker", {:method_name => :updateDate, :arguments => [new_year, new_month, new_day]})
      sleep 1
      new_date.strftime('%b %-d, %Y')

    end

    def find_in_list(qs, list_index = 0)
      listview = "listView index:#{list_index}"
      query_string = listview + ' ' + qs
      query_result = query(query_string)
      current_screen_state = query('*')
      prev_screen_state = []

      while (query_result.empty? and current_screen_state != prev_screen_state)
        prev_screen_state = current_screen_state
        scroll(listview, :down)
        sleep 1
        query_result = query(query_string)
        current_screen_state = query('*')
      end

      return query_result
    end


    def hit_enter_key
      system("#{default_device.adb_command} shell input keyevent KEYCODE_ENTER")
    end

  end
end

World(DeskAndroid::AndroidHelpers)
