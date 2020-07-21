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

    describe 'email' do

      it 'email is mandatory' do
        is_expected.to validate_presence_of(:email)
      end

      it 'email need to be valid' do
        is_expected.not_to allow_value('invalid_email.com').for(:email)
      end
    end

    describe 'birthday' do

      context 'date not valid' do
        let(:student) { FactoryBot.build(:student, birthday: Date.today) }

        it 'cant be todays date' do
          expect(student).not_to be_valid
        end
      end

      context 'date valid' do
        let(:student) { FactoryBot.build(:student, birthday: Date.today) }

        it 'birthday is mandatory' do
          is_expected.to validate_presence_of(:birthday)
        end
      end
    end
  end
end
