require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'validates' do
    describe 'name' do

      it 'name is mandatory' do
        is_expected.to validate_presence_of(:name)
      end

    end
  end
end
