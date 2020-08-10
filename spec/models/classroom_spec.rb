require 'rails_helper'

RSpec.describe Classroom, type: :model do
  describe 'validations' do
    describe 'name' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_least(6) }
    end

    describe 'school_period' do
      it { is_expected.to validate_presence_of(:school_period) }

      describe 'enum' do
        it { is_expected.to define_enum_for(:school_period).with_values(%i[morning afternoon night]) }
      end
    end

    describe 'year' do
      let(:classroom_invalid) { build(:classroom, :invalid) }
      let(:classroom) { build(:classroom) }

      it { is_expected.to validate_presence_of(:year) }
      it { expect(classroom_invalid).to be_invalid }
      it { is_expected.to validate_numericality_of(:year).only_integer }
    end
  end
end
