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
    context 'valid id' do
      let(:professor) { create(:professor) }
      before do
        professor
        create(:professor)
        get :edit, params: { id: professor.id }
      end

      it { expect(response).to render_template(:edit) }
      it { expect(assigns[:professor]).to eq(professor) }
    end
    context 'invalid id' do
      let(:professor) { create(:professor) }
      before { get :edit, params: { id: 0 } }

      it { expect(response).to redirect_to(professors_path) }
    end
  end

  describe '#show' do
    context 'invalid id' do
      let(:professor) { create(:professor) }
      before { get :show, params: { id: professor.id } }

      it 'redirect to #index' do
        expect(response).to redirect_to(professors_path)
      end
    end
  end
end
