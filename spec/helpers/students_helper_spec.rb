require 'rails_helper'
# Specs in this file have access to a helper object that includes
# the StudentsHelper. For example:
#
# describe StudentsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe StudentsHelper, type: :helper do
  describe 'student_genders_for_select' do
    it 'translate and set gender' do
      expect(helper.student_genders_for_select).to eq(Student.genders.map { |k, v| [Student.human_attribute_name("gender.#{k}"), k] })
    end
  end
end
