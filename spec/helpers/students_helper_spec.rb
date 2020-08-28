require 'rails_helper'

RSpec.describe StudentsHelper, type: :helper do
  describe 'student_genders_for_select' do
    it 'translate and set gender' do
      expect(helper.student_genders_for_select).to eq(Student.genders.map { |k, v| [Student.human_attribute_name("gender.#{k}"), k] })
    end
  end

  describe 'students_for_select' do
    let(:expected) do
      Student.all.map do |student|
        ["#{student.name}", student.id]
      end
    end

    before { create_list(:student, 3) }

    it { expect(students_for_select).to eq(expected) }
  end
end
