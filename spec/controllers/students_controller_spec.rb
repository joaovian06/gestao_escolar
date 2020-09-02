require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  let(:student) { build(:student) }
  let(:permitted_params) { [:name, :address, :email, :birthday, :gender, :disability, :avatar, enrollments_attributes: [:id, :classroom_id, :_destroy]] }
  let(:valid_params) { { student: student.attributes } }

  describe '#index' do
    let!(:students) { create_list(:student, 10) }
    before { get :index }

    it { expect(assigns[:students]).to match_array(students) }
  end

  describe '#new' do
    before { get :new }

    it { expect(response).to render_template(:new) }
  end

  describe '#edit' do
    context 'valid id' do
      let(:student) { create(:student) }

      before do
        student
        create(:student)
        get :edit, params: { id: student.id }
      end

      it { expect(response).to render_template(:edit) }
      it { expect(assigns[:student]).to eq(student) }
    end

    context 'invalid student id' do
      before { get :edit, params: { id: 0 } }

      it { expect(response).to redirect_to(students_path) }
    end
  end

  describe '#show' do
    let(:student) { create(:student) }

    context 'valid id' do
      before do
        student
        create(:student)
        get :show, params: { id: student.id }
      end

      it { expect(response).to render_template(:show) }
      it { expect(assigns[:student]).to eq(student) }
    end

    context 'invalid id' do
      before { get :show, params: { id: 0 } }

      it { expect(response).to redirect_to(students_path) }
    end
  end

  describe '#create' do
    context 'valid params' do
      let(:student) { build(:student) }

      it { is_expected.to permit(*permitted_params).for(:create, params: valid_params).on(:student) }
      it { expect { post :create, params: valid_params }.to change(Student, :count).by(1) }
      it do
        post :create, params: valid_params
        expect(controller).to set_flash[:success]
      end

      context 'redirects' do
        before { post :create, params: valid_params }

        it { expect(response).to redirect_to(students_path) }
      end
    end

    context 'invalid params' do
      let(:student) { build(:student, :invalid) }
      let(:invalid_params) { { student: student.attributes } }
      before { post :create, params: invalid_params }

      it { expect(controller).to set_flash[:error] }
      it { expect(response).to render_template(:new) }
    end
  end

  describe '#update' do
    let(:default_student_name) { 'Pedro Alvares Cabral' }
    let(:updated_name) { 'Joao Vitor Vian' }

    context 'valid params' do
      let(:student) { create(:student, name: default_student_name) }
      let(:valid_params) { { id: student.id, student: student.attributes } }
      before { patch :update, params: { id: student.id, student: { name: updated_name } } }

      it { expect(controller).to set_flash[:success] }
      it { is_expected.to permit(*permitted_params).for(:update, params: valid_params).on(:student) }

      it do
        student.reload
        expect(student.name).to eq updated_name
      end

      it { expect(response).to redirect_to(students_path) }
    end

    context 'invalid params' do
      let(:student) { create(:student, name: default_student_name) }
      before { patch :update, params: { id: student.id, student: { name: updated_name, address: '' } } }

      it { expect(controller).to set_flash[:error] }
      it { expect(response).to render_template(:edit) }
    end
  end

  describe '#destroy' do
    let!(:student) { create(:student) }

    context 'valid id' do
      context 'set flash and redirect' do
        before { delete :destroy, params: { id: student.id } }

        it { expect(controller).to set_flash[:success] }
        it { expect(response).to redirect_to(students_path) }
      end

      it do
        expect do
          delete :destroy, params: { id: student.id }
        end.to change(Student, :count).by(-1)
      end
    end

    context 'invalid id' do
      before { delete :destroy, params: { id: 0 } }

      it { expect(controller).to set_flash[:error] }
      it { expect(response).to redirect_to(students_path) }
    end
  end
end
