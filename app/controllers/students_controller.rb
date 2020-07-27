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
    @student = Student.find_by(id: params[:id])
    redirect_to students_path unless @student.present?
  end

  def create
    @student = Student.new(students_params)
    if @student.save
      redirect_to students_path
    else
      render :new
    end
  end

  def update
    render :edit
  end

  private

  def students_params
    params.require(:student).permit(:name, :address, :email, :birthday, :gender, :disability)
  end
end
