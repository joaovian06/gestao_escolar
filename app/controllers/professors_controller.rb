class ProfessorsController < ApplicationController
  def index
    @professors = Professor.all
  end

  def new
    @professor = Professor.new
  end

  def edit
    @professor = Professor.find_by(id: params[:id])
    redirect_to professors_path unless @professor.present?
  end

  def show
    @professor = Professor.find_by(id: params[:id])
    redirect_to professors_path unless @professor.present?
  end
end
