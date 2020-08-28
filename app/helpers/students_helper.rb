module StudentsHelper
  def student_genders_for_select
    Student.genders.keys.map do |keys|
      [Student.human_attribute_name("gender.#{keys}"), keys]
    end
  end

  def students_for_select
    Student.all.map do |student|
      ["#{student.name}", student.id]
    end
  end
end
