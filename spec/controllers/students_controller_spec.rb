require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  describe '#index' do
    let!(:students) { FactoryBot.create_list(:student, 10) }
    before { get :index }

    it 'return all students' do
      expect(assigns[:students]).to match_array(students)
    end
  end

  describe '#new' do
    before { get :new }

    it 'renders #new page' do
      expect(response).to render_template(:new)
    end
  end

  describe '#edit' do
    context 'given a valid id' do
      let(:student) { FactoryBot.create(:student) }

      before do
        student
        FactoryBot.create(:student)
        get :edit, params: { id: student.id }
      end

      it 'renders #edit' do
        expect(response).to render_template(:edit)
      end

      it do
        expect(assigns[:student]).to eq(student)
      end
    end
    context 'given an invalid student id' do
      before { get :edit, params: { id: 0 } }

      it 'redirect to #index' do
        expect(response).to redirect_to(students_path)
      end
    end
  end

  describe '#show' do
    let(:student) { create(:student) }

    context 'given an valid student id' do
      before do
        student
        FactoryBot.create(:student)
        get :show, params: { id: student.id }
      end

      it 'renders #show' do
        expect(response).to render_template(:show)
      end

      it do
        expect(assigns[:student]).to eq(student)
      end
    end

    context 'given an invalid student id' do
      before { get :show, params: { id: 0 } }

      it 'redirects to #index' do
        expect(response).to redirect_to(students_path)
      end
    end
  end

  describe '#create' do
    describe 'params' do
      context 'valid params' do
        let(:student) { build(:student) }
        let(:valid_params) { { student: student.attributes } }

        it 'permit params' do
          is_expected.to permit(:name, :address, :email, :birthday, :gender, :disability).for(:create, params: valid_params).on(:student)
        end

        it 'saves the student' do
          expect { post :create, params: valid_params }.to change(Student, :count).by(1)
        end

        context 'redirects' do
          before { post :create, params: valid_params }

          it 'redirect to #index' do
            expect(response).to redirect_to(students_path)
          end
        end
      end

      context 'invalid params' do
        let(:student) { build(:student, :invalid) }
        let(:invalid_params) { { student: student.attributes } }
        before { post :create, params: invalid_params }

        it 'renders new' do
          expect(response).to render_template(:new)
        end
      end
    end
  end
end
