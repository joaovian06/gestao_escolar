require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:student) { FactoryBot.create(:student) }

  describe 'validates' do
    describe 'name' do

      it 'name is mandatory' do
        is_expected.to validate_presence_of(:name)
      end

      it 'has 10 caracters at minimum' do
        expect(student.name.length).to be >= 10
      end

    end
    describe 'address' do

      it 'address is mandatory' do
        is_expected.to validate_presence_of(:address)
      end

    end
  end
end
