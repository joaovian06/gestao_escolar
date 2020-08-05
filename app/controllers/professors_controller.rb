class ProfessorsController < ApplicationController
  def index
    @professors = Professor.all
  end

  def new
    @professors = Professor.new
  end

  def edit
  end
end
