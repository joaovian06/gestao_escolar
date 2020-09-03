class EnrollmentsController < ApplicationController
  before_action :find_enrollment, only: %i[edit update destroy]
  PER_PAGE = 10

  def index
    @enrollments = Enrollment.order(created_at: :desc).page(param_page).per(PER_PAGE)
  end

  def new
    @enrollment = Enrollment.new
  end

  def create
    @enrollment = Enrollment.new(enrollments_params)
    if @enrollment.save
      redirect_to_index
      flash[:success] = t('.success')
    else
      flash[:error] = t('.error')
      render(:new)
    end
  end

  def destroy
    if @enrollment.present?
      @enrollment.destroy
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
    redirect_to(enrollments_path)
  end

  def find_enrollment
    @enrollment = Enrollment.find_by(id: params[:id])
  end

  def enrollments_params
    params.require(:enrollment).permit(%i[student_id classroom_id])
  end
end
