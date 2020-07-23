class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def edit
    @student = Student.find_by(id: params[:id])
    redirect_to students_path unless @student.present?
  end

  def show
  end
end
