require 'rails_helper'

RSpec.describe ProfessorsController, type: :controller do
  describe '#index' do
    let!(:professors) { create_list(:professor, 10) }
    before { get :index }

    it 'show all professors' do
      expect(assigns[:professors]).to match_array(professors)
    end
  end
end
