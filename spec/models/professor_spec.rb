require 'rails_helper'

RSpec.describe Professor, type: :model do
  describe 'validates' do
    describe 'name' do
      let(:professor) { build(:professor, name: 'Pedro Pedroso') }

      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_least(10) }
    end

    describe 'cellphone' do
      let(:professor) { build(:professor) }

      it { is_expected.to validate_presence_of(:cellphone) }
      it { is_expected.to validate_length_of(:cellphone).is_equal_to(10) }
      it 'not allow cellphone numbers out of the pattern' do
        is_expected.not_to allow_value('abcde-fhgj').for(:cellphone)
      end
    end
  end
end
