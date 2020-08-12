module StudentsHelper
  def student_genders_for_select
    Student.genders.map do |k, v|
      [Student.human_attribute_name("gender.#{k}"), k]
    end
  end
end
