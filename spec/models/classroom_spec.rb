require 'rails_helper'

RSpec.describe Classroom, type: :model do
  describe 'validations' do
    describe 'name' do
      it { is_expected.to validate_presence_of(:name) }
    end
  end
end
