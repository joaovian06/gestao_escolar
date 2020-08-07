class ProfessorsController < ApplicationController
  before_action :find_professor, only: %i[show edit update destroy]

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
    redirect_to professors_path unless @professor.present?
  end

  def create
    @professor = Professor.new(professors_params)
    @professor.save ? redirect_to(professors_path) : render(:new)
  end

  def update
    @professor.update(professors_params) ? redirect_to(professors_path) : render(:edit)
  end

  def destroy
    @professor.destroy if @professor.present?

    redirect_to professors_path
  end

  private

  def find_professor
    @professor = Professor.find_by(id: params[:id])
  end

  def professors_params
    params.require(:professor).permit(:name, :cellphone)
  end
end
