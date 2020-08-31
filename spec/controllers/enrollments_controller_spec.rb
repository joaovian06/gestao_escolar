require 'rails_helper'

RSpec.describe EnrollmentsController, type: :controller do
  let(:permitted_params) { %i[student_id classroom_id] }
  let(:classroom) { create(:classroom) }
  let(:student) { create(:student) }
  let(:enrollment) { create(:enrollment) }
  let(:valid_params) { { id: enrollment.id, enrollment: enrollment.attributes } }

  describe '#index' do
    let!(:enrollments) { create_list(:enrollment, 10) }
    before { get :index }

    it { expect(response).to render_template(:index) }
    it { expect(assigns[:enrollments]).to eq(enrollments) }
  end

  describe '#new' do
    before { get :new }

    it { expect(response).to render_template(:new) }
    it { expect(assigns[:enrollment]).to be_a_new(Enrollment) }
  end

  describe '#edit' do
    let(:enrollment) { create(:enrollment) }

    context 'valid id' do
      before do
        enrollment
        create(:enrollment)
        get :edit, params: { id: enrollment.id }
      end

      it { expect(assigns[:enrollment]).to eq(enrollment) }
      it { expect(response).to render_template(:edit) }
    end

    context 'invalid id' do
      before { get :edit, params: { id: 0 } }

      it { expect(response).to redirect_to(enrollments_path) }
    end
  end

  describe '#create' do
    context 'valid params' do
      let(:enrollment) { build(:enrollment, classroom: classroom, student: student) }
      before { post :create, params: valid_params }

      it { is_expected.to permit(*permitted_params).for(:create, params: valid_params).on(:enrollment) }
      it { expect(response).to redirect_to(enrollments_path) }
    end

    context 'invalid params' do
      let(:enrollment) { build(:enrollment, :invalid) }
      let(:invalid_params) { { enrollment: enrollment.attributes } }

      before { post :create, params: invalid_params }

      it { expect(response).to render_template(:new) }
    end
  end

  describe '#update' do
    let(:default_student) { create(:student) }
    let(:enrollment) { create(:enrollment, student: default_student) }

    context 'valid params' do
      let(:updated_student) { create(:student) }
      before do
        enrollment
        patch :update, params: { id: enrollment.id, enrollment: { student_id: updated_student } }
      end

      it { is_expected.to permit(*permitted_params).for(:update, params: valid_params).on(:enrollment) }

      it 'update attributes' do
        enrollment.reload
        expect(enrollment.student).to eq(updated_student)
      end

      it { expect(response).to redirect_to(enrollments_path) }
    end

    context 'invalid params' do
      before do
        enrollment
        patch :update, params: { id: enrollment.id, enrollment: { student_id: nil } }
      end

      it { expect(response).to render_template(:edit) }
    end
  end

  describe '#destroy' do
    context 'valid id' do
      before { enrollment }

      it { expect { delete :destroy, params: { id: enrollment } }.to change(Enrollment, :count).by(-1) }
    end

    context 'invalid id' do
      before { delete :destroy, params: { id: 0 } }

      it { expect(response).to redirect_to(enrollments_path) }
    end
  end
end
