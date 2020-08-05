require 'rails_helper'

RSpec.describe Professor, type: :model do

  describe 'validates' do
    describe 'name' do
      let(:professor) { build(:professor, name: 'Pedro') }
      it { is_expected.to validate_presence_of(:name) }
      it 'must have 10 caracters at minimum' do
        expect(professor.name.length).to be >= 10
      end
    end
  end
end
