require 'rails_helper'

RSpec.describe ProfessorsController, type: :controller do
  describe '#index' do
    let(:students) { build(:student, 10) }
    before { get :index }

    it 'show all professors' do
      expect(assigns[:students]).to match_array(students)
    end
  end
end
