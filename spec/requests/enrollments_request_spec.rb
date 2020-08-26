require 'rails_helper'

RSpec.describe "Enrollments", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/enrollments/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/enrollments/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/enrollments/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/enrollments/show"
      expect(response).to have_http_status(:success)
    end
  end

end
