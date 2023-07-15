class StudentsController < ApplicationController
  before_action :find_student, only: %i[edit show update destroy]
  PER_PAGE = 10

  def index
    @students = Student.order(created_at: :desc).page(param_page).per(PER_PAGE)
  end

  def new
    @student = Student.new
  end

  def edit
    redirect_index_missing_student
  end

  def show
    redirect_index_missing_student
  end

  def create
    @student = Student.new(students_params)
    if @student.save
      redirect_to_index
      flash[:success] = t('.success')
    else
      flash[:error] = t('.error')
      render(:new)
    end
  end

  def update
    if @student.update(students_params)
      flash[:success] = t('.success')
      redirect_to_index
    else
      flash[:error] = t('.error')
      render(:edit)
    end
  end

  def destroy
    if @student.present?
      @student.destroy
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
    redirect_to(students_path)
  end

  def redirect_index_missing_student
    redirect_to_index unless @student.present?
  end

  def find_student
    @student = Student.find_by(id: params[:id])
  end

  def students_params
    params.require(:student).permit(:name, :address, :email, :birthday, :gender, :disability, :avatar, enrollments_attributes: [:id, :classroom_id ,:_destroy])
  end
end
