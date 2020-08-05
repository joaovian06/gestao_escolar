class ProfessorsController < ApplicationController
  def index
    @professors = Professor.all
  end
end
