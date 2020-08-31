require 'rails_helper'

RSpec.describe Classroom, type: :model do
  describe 'validations' do
    describe 'name' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_least(6) }

      describe 'uniquiness' do
        describe 'having two classes with the same name in the same year' do
          let!(:classroom1) { create(:classroom, name: 'first class', year: 2020) }
          let(:classroom2) { build(:classroom, name: 'first class', year: 2020) }

          it { expect(classroom2).to be_invalid }
        end

        describe 'having two classes with the same name in different years' do
          let!(:classroom1) { create(:classroom, name: 'first class', year: 2020) }
          let(:classroom2) { build(:classroom, name: 'first class', year: 2019) }

          it { expect(classroom2).to be_valid }
          it { is_expected.to validate_uniqueness_of(:name).scoped_to(:year) }
        end
      end
    end

    describe 'school_period' do
      it { is_expected.to validate_presence_of(:school_period) }

      describe 'enum' do
        it { is_expected.to define_enum_for(:school_period).with_values(%i[morning afternoon night]) }
      end
    end

    describe 'year' do
      it { is_expected.to validate_presence_of(:year) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:enrollments).inverse_of(:classroom) }
    it { is_expected.to accept_nested_attributes_for(:enrollments).allow_destroy(true) }
  end
end
