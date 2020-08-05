class ProfessorsController < ApplicationController
  def index
    @professors = Professor.all
  end

  def new
    @professors = Professor.new
  end

  def edit
    redirect_to professors_path
  end
end
