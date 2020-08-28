require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe 'validations' do
    describe 'student' do
      describe 'uniqueness' do
        let(:student) { create(:student) }
        let(:classroom) { create(:classroom) }
        let!(:enrollment) { create(:enrollment, classroom: classroom, student: student) }

        it { is_expected.to validate_uniqueness_of(:student_id).scoped_to(:classroom_id) }
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
    it { is_expected.to belong_to(:classroom).inverse_of(:enrollments) }
    it { is_expected.to belong_to(:student).inverse_of(:enrollments) }
  end

  describe 'callbacks' do
    describe '#before_validation' do
      context 'set_registration_num' do
        let(:time_now) { Time.now }
        let(:student) { create(:student) }
        let(:classroom) { create(:classroom) }
        let(:enrollment) { build(:enrollment, student: student, classroom: classroom) }

        before do
          allow(Time).to receive(:now).and_return(time_now)
          enrollment.validate
        end

        it { expect(enrollment.registration_num).to eq("#{time_now.to_f}") }
      end
    end
  end
end
