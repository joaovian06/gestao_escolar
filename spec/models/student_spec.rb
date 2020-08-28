require 'rails_helper'

RSpec.describe Student, type: :model do
  subject(:student) { FactoryBot.build(:student) }

  describe 'validates' do
    describe 'name' do
      it { is_expected.to validate_presence_of(:name) }
      it { expect(student.name.length).not_to be < 10 }
    end

    describe 'address' do
      it { is_expected.to validate_presence_of(:address) }
    end

    describe 'email' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.not_to allow_value('invalid_email.com').for(:email) }
    end

    describe 'birthday' do
      context 'date not valid' do
        let(:student) { FactoryBot.build(:student, birthday: Date.today) }

        it { expect(student).not_to be_valid }
      end

      context 'date valid' do
        it { is_expected.to validate_presence_of(:birthday) }
      end
    end

    describe 'gender' do
      it { is_expected.to validate_presence_of(:gender) }

      describe 'enum' do
        it { is_expected.to define_enum_for(:gender).with_values(%i[male female]) }
      end
    end
  end

  describe 'mounts' do

    it { expect(student.avatar).to be_a(AvatarUploader) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:enrollments).inverse_of(:student) }
    it { is_expected.to accept_nested_attributes_for(:enrollments) }
  end
end
