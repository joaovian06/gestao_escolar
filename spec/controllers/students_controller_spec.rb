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
      is_expected.to render_template :new
    end
  end
end
