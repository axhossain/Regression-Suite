module DeskBase
  def android?
    ENV[PLATFORM] == ANDROID
  end

  def ios?
    ENV[PLATFORM] == IOS
  end

  def custom_field_by_type(type)
    CASE_CUSTOM_FIELDS[type]
  end

  def custom_field_types
    CUSTOM_FIELD_TYPES
  end
end
