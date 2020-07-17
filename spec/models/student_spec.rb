require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'validates' do
    describe 'name' do
      it 'name is mandatory' do
        is_expected.to validate_presence_of(:name)
      end
    end
    describe 'address' do
      it 'address need to be larger than 15 caracters' do
        expect(student.address.length).to be > 15
      end
    end
  end
end
