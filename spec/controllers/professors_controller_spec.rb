require 'rails_helper'

RSpec.describe ProfessorsController, type: :controller do
  describe '#index' do
    let!(:professors) { create_list(:professor, 10) }
    before { get :index }

    it { expect(assigns[:professors]).to match_array(professors) }
  end

  describe '#new' do
    before { get :new }

    it 'render #new template' do
      expect(response).to render_template(:new)
    end
  end
end
