class ProfessorsController < ApplicationController
  before_action :find_professor, only: %i[show edit update destroy]
  PER_PAGE = 10

  def index
    @professors = Professor.order(created_at: :desc).page(param_page).per(PER_PAGE)
  end

  def new
    @professor = Professor.new
  end

  def edit
    redirect_index_missing_professor
  end

  def show
    redirect_index_missing_professor
  end

  def create
    @professor = Professor.new(professors_params)
    if @professor.save
      redirect_to_index
      flash[:success] = t('.success')
    else
      flash[:error] = t('.error')
      render(:new)
    end
  end

  def update
    if @professor.update(professors_params)
      redirect_to_index
      flash[:success] = t('.success')
    else
      flash[:error] = t('.error')
      render(:edit)
    end
  end

  def destroy
    if @professor.present?
      @professor.destroy
      flash[:success] = t('.success')
    else
      flash[:error] = t('.error')
    end
    redirect_to_index
  end

  private

  def param_page
    params[:page] || 1
  end

  def redirect_to_index
    redirect_to(professors_path)
  end

  def redirect_index_missing_professor
    redirect_to_index unless @professor.present?
  end

  def find_professor
    @professor = Professor.find_by(id: params[:id])
  end

  def professors_params
    params.require(:professor).permit(:name, :cellphone)
  end
end
