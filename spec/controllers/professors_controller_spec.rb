require 'rails_helper'

RSpec.describe ProfessorsController, type: :controller do
  let(:permitted_params) { %i[name cellphone] }
  let(:valid_params) { { id: professor.id, professor: professor.attributes } }
  let(:professor) { create(:professor) }

  describe '#index' do
    context 'all professors' do
      let(:professors) { create_list(:professor, 10) }
      before { get :index }

      it { expect(assigns[:professors]).to match_array(professors) }
    end

    describe 'paginate' do
      let!(:professors) { create_list(:professor, 11) }

      context 'param page present' do
        before { get :index, params: { page: 2 } }

        it { expect(assigns[:professors].length).to eq(1) }
      end

      context 'param page not present' do
        before { get :index }

        it { expect(assigns[:professors].length).to eq(10) }
      end
    end

    describe 'ordenate' do
      let!(:professor1) { create(:professor, created_at: DateTime.new(2020, 9, 20, 10, 0, 0)) }
      let!(:professor2) { create(:professor, created_at: DateTime.new(2020, 9, 19, 10, 0, 0)) }
      let!(:professor3) { create(:professor, created_at: DateTime.new(2020, 9, 21, 10, 0, 0)) }

      before { get :index }

      it { expect(assigns[:professors]).to eq([professor3, professor1, professor2]) }
    end
  end

  describe '#new' do
    before { get :new }

    it { expect(response).to render_template(:new) }
  end

  describe '#edit' do
    context 'valid id' do
      before do
        professor
        create(:professor)
        get :edit, params: { id: professor.id }
      end

      it { expect(response).to render_template(:edit) }
      it { expect(assigns[:professor]).to eq(professor) }
    end
    context 'invalid id' do
      before do
        professor
        get :edit, params: { id: 0 }
      end

      it { expect(response).to redirect_to(professors_path) }
    end
  end

  describe '#show' do
    context 'valid id' do
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
      let(:professor) { build(:professor) }
      let(:valid_params) { { professor: professor.attributes } }
      before { post :create, params: valid_params }

      it { expect(controller).to set_flash[:success] }
      it { is_expected.to permit(*permitted_params).for(:create, params: valid_params).on(:professor) }
      it { expect(response).to redirect_to(professors_path) }
    end

    context 'invalid params' do
      let(:professor) { build(:professor, :invalid) }
      let(:invalid_params) { { professor: professor.attributes } }
      before { post :create, params: invalid_params }

      it { expect(controller).to set_flash[:error] }
      it { expect(response).to render_template(:new) }
    end
  end

  describe '#update' do
    let(:default_professor_name) { 'Mr. Roberto Marie' }
    let(:updated_professor_name) { 'Tatiana Eva-Marie' }
    let(:professor) { create(:professor, name: default_professor_name) }

    context 'valid params' do
      before do
        professor
        patch :update, params: { id: professor.id, professor: { name: updated_professor_name } }
      end

      it { is_expected.to permit(*permitted_params).for(:create, params: valid_params).on(:professor) }

      it 'update attribute' do
        professor.reload
        expect(professor.name).to eq updated_professor_name
      end

      it { expect(controller).to set_flash[:success] }
      it { expect(response).to redirect_to(professors_path) }
    end

    context 'invalid params' do
      before do
        professor
        patch :update, params: { id: professor.id, professor: { name: updated_professor_name, cellphone: '' } }
      end

      it { expect(controller).to set_flash[:error] }
      it { expect(response).to render_template(:edit) }
    end
  end

  describe '#destroy' do
    before { professor }

    context 'valid id' do
      context 'set flash and redirect' do
        before { delete :destroy, params: { id: professor.id } }

        it { expect(response).to redirect_to(professors_path) }
        it { expect(controller).to set_flash[:success] }
      end

      it do
        expect do
          delete :destroy, params: { id: professor.id }
        end.to change(Professor, :count).by(-1)
      end
    end

    context 'invalid id' do
      before { delete :destroy, params: { id: 0 } }

      it { expect(controller).to set_flash[:error] }
      it { expect(response).to redirect_to(professors_path) }
    end
  end
end
