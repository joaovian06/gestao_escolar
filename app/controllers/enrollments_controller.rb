class EnrollmentsController < ApplicationController
  before_action :find_enrollment, only: %i[edit update destroy]
  def index
    @enrollments = Enrollment.all
  end

  def edit
    if @enrollment.present?
      render(:edit)
    else
      redirect_to(enrollments_path)
    end
  end

  def new
    @enrollment = Enrollment.new
  end

  def create
    @enrollment = Enrollment.new(enrollments_params)
    if @enrollment.save
      redirect_to(enrollments_path)
    else
      render(:new)
    end
  end

  def update
    if @enrollment.update(enrollments_params)
      redirect_to(enrollments_path)
    else
      render(:edit)
    end
  end

  def destroy
    @enrollment.destroy if @enrollment.present?
    redirect_to(enrollments_path)
  end

  private

  def find_enrollment
    @enrollment = Enrollment.find_by(id: params[:id])
  end

  def enrollments_params
    params.require(:enrollment).permit(%i[registration_num student_id classroom_id])
  end
end
