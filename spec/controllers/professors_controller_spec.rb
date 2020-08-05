require 'rails_helper'

RSpec.describe ProfessorsController, type: :controller do
  describe '#index' do
    let!(:professors) { create_list(:professor, 10) }
    before { get :index }

    it { expect(assigns[:professors]).to match_array(professors) }
  end

  describe '#new' do
    before { get :new }

    it { expect(response).to render_template(:new) }
  end

  describe '#edit' do
    context 'invalid id' do
      let(:professor) { create(:professor) }
      before { get :edit, params: { id: 0 } }

      it 'render #index' do
        expect(response).to render_template(professors_path)
      end
    end
  end
end
