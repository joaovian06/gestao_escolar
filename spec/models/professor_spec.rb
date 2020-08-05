require 'rails_helper'

RSpec.describe Professor, type: :model do
  let(:professor) { build(:professor) }

  describe 'validates' do
    describe 'name' do
      it 'is mandatory' do
        is_expected.to validate_presence_of(:name)
      end
    end
  end
end
