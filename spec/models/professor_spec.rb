require 'rails_helper'

RSpec.describe Professor, type: :model do
  describe 'validates' do
    describe 'name' do
      let(:professor) { build(:professor, name: 'Pedro Pedroso') }

      it { is_expected.to validate_presence_of(:name) }
      it 'must have 10 caracters at minimum' do
        is_expected.to validate_length_of(:name).is_at_least(10)
      end
    end
  end
end
