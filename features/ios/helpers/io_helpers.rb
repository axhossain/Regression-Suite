# noinspection RubyResolve
require 'calabash-cucumber/ibase'
require 'byebug'

module DeskiOS

  module IOSHelpers

    def enter_text(field, text, options = {})
      default_options = { wait_for_keyboard: true, prepend_whitespace: 0}
      options = default_options.merge options

      if (options[:wait_for_keyboard]) 
        wait_for_element_exists(field)
        touch(field)
        # noinspection RubyControlFlowConversionInspection
        wait_for_keyboard
      end

      num_spaces = options[:prepend_whitespace]
      text = (' ' * num_spaces) + text[0...text.length-num_spaces]
      keyboard_enter_text(text)

      text
    end

    def enter_text_date(field, text=Time.now.strftime("%b %d, %Y %H:%M"))
      self.enter_text(field, text )
    end

    def enter_text_characters(field, count=50, options = {})
      words = RandomEnglishWordsGenerator.new
      text = words.characters(count)
      enter_text(field, text, options)
    end

    def enter_text_numbers(field, count=999999999999999)
      numbers = rand(1..count)
      enter_text(field, numbers.to_s)
      sleep 1
      numbers
    end

    def wait_for_cloud
      wait_for_elements_do_not_exist('Window DSCloudActivityIndicator')
    end

    def randomize_slider(min_value=0, max_value=10, forbidden_value='undefined', slider_index=0)
      new_value = Random.rand(min_value..max_value).to_s
      if forbidden_value != 'undefined'
        wait_for(:timeout => 5) do
          new_value = Random.rand(min_value..max_value).to_s
          new_value != forbidden_value
        end
      end
      map("slider index:#{slider_index}", :changeSlider, new_value)
      sleep 1
      new_value
    end

    def randomize_selection(query, min_index = 0,forbidden_value = 'undefined')
      query_string = query.to_s + ' label'
      total_options = query(query_string).count

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
      dt = DateTime.new(new_year, new_month, new_day)
      picker_set_date_time(dt)
      sleep 1
      dt.strftime('%b %e, %Y')
    end

  end
end

World(DeskiOS::IOSHelpers)
