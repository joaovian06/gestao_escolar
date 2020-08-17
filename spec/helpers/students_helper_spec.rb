require 'rails_helper'

RSpec.describe StudentsHelper, type: :helper do
  describe 'student_genders_for_select' do
    it 'translate and set gender' do
      expect(helper.student_genders_for_select).to eq(Student.genders.map { |k, v| [Student.human_attribute_name("gender.#{k}"), k] })
    end
  end
end
