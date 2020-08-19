module ClassroomsHelper
  def classroom_school_periods_for_select
    Classroom.school_periods.keys.map do |key|
      [Classroom.human_attribute_name("school_period.#{key}"), key]
    end
  end
end
