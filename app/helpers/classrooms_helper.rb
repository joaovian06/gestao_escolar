module ClassroomsHelper
  def classroom_school_periods_for_select
    Classroom.school_periods.map do |k, v|
      [Classroom.human_attribute_name("school_period.#{k}"), k]
    end
  end
end
