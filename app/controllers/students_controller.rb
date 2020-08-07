class StudentsController < ApplicationController
  before_action :find_student, only: %i[edit show update destroy]

  def index
    @students = Student.all
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
    @student.save ? redirect_to(students_path) : render(:new)
  end

  def update
    @student.update(students_params) ? redirect_to(students_path) : render(:edit)
  end

  def destroy
    @student.destroy if @student.present?
    redirect_index_missing_student
  end

  private

  def redirect_index_missing_student
    redirect_to students_path unless @student.present?
  end

  def find_student
    @student = Student.find_by(id: params[:id])
  end

  def students_params
    params.require(:student).permit(:name, :address, :email, :birthday, :gender, :disability)
  end
end
