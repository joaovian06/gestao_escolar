module StudentsHelper
  def student_genders_for_select
    Student.genders.keys.map do |key|
      [Student.human_attribute_name("gender.#{key}"), key]
    end
  end

  def students_for_select
    Student.all.map do |student|
      [student.name, student.id]
    end
  end
end
