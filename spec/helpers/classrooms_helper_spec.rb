require 'rails_helper'

RSpec.describe ClassroomsHelper, type: :helper do
  describe 'classroom_school_periods_for_select' do
    it 'translate options and set school period' do
      expect(classroom_school_periods_for_select).to eq(Classroom.school_periods.map { |k, v| [Classroom.human_attribute_name("school_period.#{k}"), k] })
    end
  end

  describe 'classrooms_for_select' do
    let(:expected) do
      Classroom.all.map do |classroom|
        ["#{classroom.name}/#{classroom.year}", classroom.id]
      end
    end

    before { create_list(:classroom, 3) }

    it { expect(classrooms_for_select).to eq(expected) }
  end
end
