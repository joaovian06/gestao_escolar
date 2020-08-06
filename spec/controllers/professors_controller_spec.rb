require 'rails_helper'

RSpec.describe ProfessorsController, type: :controller do
  describe '#index' do
    let(:professors) { create_list(:professor, 10) }
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
    context 'valid id' do
      let(:professor) { create(:professor) }
      before do
        professor
        create(:professor)
        get :show, params: { id: professor.id }
      end

      it { expect(assigns[:professor]).to eq(professor) }
      it { expect(response).to render_template(:show) }
    end

    context 'invalid id' do
      before { get :show, params: { id: 0 } }

      it { expect(response).to redirect_to(professors_path) }
    end
  end

  describe '#create' do
    context 'valid params' do
      let(:permitted_params) { %i[name cellphone] }
      let(:professor) { build(:professor) }
      let(:valid_params) { { professor: professor.attributes } }
      before { post :create, params: valid_params }

      it { is_expected.to permit(*permitted_params).for(:create, params: valid_params).on(:professor) }
      it { expect(response).to redirect_to professors_path }
    end

    context 'invalid params' do
      let(:professor) { build(:professor, :invalid) }
      let(:invalid_params) { { professor: professor.attributes } }
      before { post :create, params: invalid_params }

      it { expect(response).to render_template(:new) }
    end
  end

  describe '#update' do
    let(:default_professor_name) { 'Mr. Roberto Marie' }
    let(:updated_professor_name) { 'Tatiana Eva-Marie' }

    context 'valid params' do
      let(:permitted_params) { %i[name cellphone] }
      let(:professor) { create(:professor, name: default_professor_name) }
      let(:valid_params) { { id: professor.id, professor: professor.attributes } }
      before { patch :update, params: { id: professor.id, professor: { name: updated_professor_name } } }

      it 'permit params' do
        is_expected.to permit(*permitted_params).for(:create, params: valid_params).on(:professor)
      end

      it 'update attribute' do
        professor.reload
        expect(professor.name).to eq updated_professor_name
      end

      it 'redirect to #index' do
        expect(response).to redirect_to professors_path
      end
    end

    context 'invalid params' do
      let(:professor) { create(:professor, name: default_professor_name) }
      before { patch :update, params: { id: professor.id, professor: { name: updated_professor_name, cellphone: '' } } }

      it 'redirect to #index' do
        expect(response).to render_template :edit
      end
    end
  end
end
