require 'rails_helper'
# Specs in this file have access to a helper object that includes
# the ClassroomsHelper. For example:
#
# describe ClassroomsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ClassroomsHelper, type: :helper do
  describe 'classroom_school_periods_for_select' do
    it 'translate options and set school period' do
      expect(helper.classroom_school_periods_for_select).to eq(Classroom.school_periods.map { |k, v| [Classroom.human_attribute_name("school_period.#{k}"), k] })
    end
  end
end
