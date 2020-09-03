require 'rails_helper'

RSpec.describe ClassroomsController, type: :controller do
  let(:permitted_params) { [:name, :school_period, :year, enrollments_attributes: [:id, :student_id ,:_destroy]] }
  let(:valid_params) { { id: classroom.id, classroom: classroom.attributes } }
  let(:classroom) { create(:classroom) }

  describe '#index' do
    context 'all classrooms' do
      let!(:classes) { create_list(:classroom, 2) }
      before { get :index }

      it { expect(assigns[:classrooms]).to eq(classes) }
    end

    describe 'paginate' do
      let!(:classrooms) { create_list(:classroom, 11) }

      context 'param page present' do
        before { get :index, params: { page: 2 } }

        it { expect(assigns[:classrooms].length).to eq(1) }
      end

      context 'param page not present' do
        before { get :index }

        it { expect(assigns[:classrooms].length).to eq(10) }
      end
    end

    describe 'ordenate' do
      let!(:class1) { create(:classroom, created_at: DateTime.new(2020, 9, 20, 10, 0, 0)) }
      let!(:class2) { create(:classroom, created_at: DateTime.new(2020, 9, 19, 10, 0, 0)) }
      let!(:class3) { create(:classroom, created_at: DateTime.new(2020, 9, 21, 10, 0, 0)) }

      before { get :index }

      it { expect(assigns[:classrooms]).to eq([class3, class1, class2]) }
    end
  end

  describe '#new' do
    before { get :new }

    it { expect(response).to render_template(:new) }
    it { expect(assigns[:classroom]).to be_a_new(Classroom) }
  end

  describe '#show' do
    context 'valid id' do
      before do
        classroom
        create(:classroom)
        get :show, params: { id: classroom }
      end

      it { expect(response).to render_template(:show) }
      it { expect(assigns[:classroom]).to eq(classroom) }
    end

    context 'invalid id' do
      before do
        classroom
        get :show, params: { id: 0 }
      end

      it { expect(response).to redirect_to(classrooms_path) }
    end
  end

  describe '#edit' do
    context 'valid id' do
      before do
        classroom
        create(:classroom)
        get :edit, params: { id: classroom }
      end

      it { expect(response).to render_template(:edit) }
      it { expect(assigns[:classroom]).to eq(classroom) }
    end

    context 'invalid id' do
      before { get :edit, params: { id: 0 } }
      it { expect(response).to redirect_to(classrooms_path) }
    end
  end

  describe '#create' do
    context 'valid params' do
      let(:classroom) { build(:classroom) }
      let(:valid_params) { { classroom: classroom.attributes } }
      before { post :create, params: valid_params }

      it { expect(controller).to set_flash[:success] }
      it { is_expected.to permit(*permitted_params).for(:create, params: valid_params).on(:classroom) }
      it { expect(response).to redirect_to(classrooms_path) }
    end

    context 'invalid params' do
      let(:classroom) { build(:classroom, :invalid) }
      let(:invalid_params) { { classroom: classroom.attributes } }
      before { post :create, params: invalid_params }

      it { expect(controller).to set_flash[:error] }
      it { expect(response).to render_template(:new) }
    end
  end

  describe '#update' do
    let(:default_class_name) { 'TurmaX' }
    let(:updated_class_name) { 'TurmaY' }
    let!(:classroom) { create(:classroom, name: default_class_name) }

    context 'valid params' do
      before do
        classroom
        patch :update, params: { id: classroom.id, classroom: { name: updated_class_name } }
      end

      it { expect(controller).to set_flash[:success] }
      it { is_expected.to permit(*permitted_params).for(:update, params: valid_params).on(:classroom) }

      it 'update classroom attributes' do
        classroom.reload
        expect(classroom.name).to eq updated_class_name
      end

      it { expect(response).to redirect_to(classrooms_path) }
    end

    context 'invalid params' do
      before do
        classroom
        patch :update, params: { id: classroom.id, classroom: { name: updated_class_name, year: "" } }
      end

      it { expect(controller).to set_flash[:error] }
      it { expect(response).to render_template(:edit) }
    end
  end

  describe 'destroy' do
    context 'valid id' do
      before { classroom }

      it { expect { delete :destroy, params: { id: classroom.id } }.to change(Classroom, :count).by(-1) }
      it do
        delete :destroy, params: { id: classroom.id }
        expect(controller).to set_flash[:success]
      end
    end

    context 'invalid id' do
      before do
        classroom
        delete :destroy, params: { id: 0 }
      end

      it { expect(controller).to set_flash[:error] }
      it { expect(response).to redirect_to(classrooms_path) }
    end
  end
end
