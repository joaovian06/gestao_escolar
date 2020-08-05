class ProfessorsController < ApplicationController
  def index
    @professors = Professor.all
  end

  def new
  end
end
