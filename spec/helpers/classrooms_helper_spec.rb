require 'rails_helper'

RSpec.describe ClassroomsHelper, type: :helper do
  describe 'classroom_school_periods_for_select' do
    it 'translate options and set school period' do
      expect(helper.classroom_school_periods_for_select).to eq(Classroom.school_periods.map { |k, v| [Classroom.human_attribute_name("school_period.#{k}"), k] })
    end
  end
end
