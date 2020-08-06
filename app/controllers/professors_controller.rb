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

  def create
    @professor = Professor.new(professors_params)
    @professor.save ? redirect_to(professors_path) : render(:new)
  end

  def update
    @professor = Professor.find_by(id: params[:id])
    @professor.update(professors_params) ? redirect_to(professors_path) : render(:edit)
  end

  def destroy
    redirect_to professors_path
  end

  private

  def professors_params
    params.require(:professor).permit(:name, :cellphone)
  end
end
