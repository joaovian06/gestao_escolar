module ClassroomsHelper
  def classroom_school_periods_for_select
    Classroom.school_periods.keys.map do |keys|
      [Classroom.human_attribute_name("school_period.#{keys}"), keys]
    end
  end

  def classrooms_for_select
    Classroom.all.map do |classroom|
      ["#{classroom.name}/#{classroom.year}", classroom.id]
    end
  end
end
