require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe 'validations' do
    describe 'registration number' do
      it { is_expected.to validate_presence_of(:registration_num) }
      it { is_expected.to validate_length_of(:registration_num).is_at_least(5) }
      it { is_expected.to validate_uniqueness_of(:registration_num) }
    end

    describe 'student' do
      describe 'uniqueness' do
        let(:student) { create(:student) }
        let(:classroom) { create(:classroom) }
        let!(:enrollment) { create(:enrollment, classroom: classroom, student: student) }
        let(:second_enrollment) { build(:enrollment, classroom: classroom, student: student) }

        it { expect(enrollment).to be_valid }
        it { expect(second_enrollment).to be_invalid }
        it { expect(second_enrollment).to have(1).error_on(:student_id) }
      end

      it { is_expected.to validate_presence_of(:student) }
    end

    describe 'classroom' do
      it { is_expected.to validate_presence_of(:classroom) }
    end
  end

  describe 'factory' do
    it { expect(build(:enrollment)).to be_valid }
    it { expect(build(:enrollment, :invalid)).to be_invalid }
  end

  describe 'belongs' do
    it { is_expected.to belong_to(:classroom) }
    it { is_expected.to belong_to(:student) }
  end
end
