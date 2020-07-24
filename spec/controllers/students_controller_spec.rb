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
    let(:student) { FactoryBot.create(:student) }

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
    context 'valid params' do
      before do
        post :create
      end

      it 'permit params' do
        is_expected.to permit(:name, :address, :email, :birthday, :gender, :disability).for(:create, params: { name: 'Joao Vitor Vian', address: 'rua brotas', email: 'joao.vian@caiena.net', birthday: 'Mon, 05 Sep 2005', gender: 1, disability: false }).on(:student)
      end
    end
  end
end
