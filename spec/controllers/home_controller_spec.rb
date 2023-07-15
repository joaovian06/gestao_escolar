require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe '#index' do
    before { get :index }

    it { is_expected.to render_template(:index) }
  end
end
