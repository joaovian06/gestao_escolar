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

  describe '#create' do
    context 'valid params' do
      let(:enrollment) { build(:enrollment, classroom: classroom, student: student) }
      before { post :create, params: valid_params }

      it { expect(controller).to set_flash[:success] }
      it { is_expected.to permit(*permitted_params).for(:create, params: valid_params).on(:enrollment) }
      it { expect(response).to redirect_to(enrollments_path) }
    end

    context 'invalid params' do
      let(:enrollment) { build(:enrollment, :invalid) }
      let(:invalid_params) { { enrollment: enrollment.attributes } }

      before { post :create, params: invalid_params }

      it { expect(controller).to set_flash[:error] }
      it { expect(response).to render_template(:new) }
    end
  end

  describe '#destroy' do
    context 'valid id' do
      before { enrollment }

      context 'set flash and redirect' do
        before { delete :destroy, params: { id: enrollment } }

        it { expect(response).to redirect_to(enrollments_path) }
        it { expect(controller).to set_flash[:success] }
      end

      it do
        expect do
          delete :destroy, params: { id: enrollment }
        end.to change(Enrollment, :count).by(-1)
      end
    end

    context 'invalid id' do
      before { delete :destroy, params: { id: 0 } }

      it { expect(controller).to set_flash[:error] }
      it { expect(response).to redirect_to(enrollments_path) }
    end
  end
end
