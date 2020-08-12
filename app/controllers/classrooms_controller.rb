class ClassroomsController < ApplicationController
  before_action :find_classroom, only: %i[edit show update destroy]

  def index
    @classrooms = Classroom.all
  end

  def edit
    redirect_index_missing_classroom
  end

  def new
    @classroom = Classroom.new
  end

  def show
    redirect_index_missing_classroom
  end

  def create
    @classroom = Classroom.new(classrooms_params)
    @classroom.save ? redirect_to(classrooms_path) : render(:new)
  end

  def update
    @classroom.update(classrooms_params) ? redirect_to(classrooms_path) : render(:edit)
  end

  def destroy
    @classroom.destroy if @classroom.present?
    redirect_to(classrooms_path)
  end

  private

  def redirect_index_missing_classroom
    redirect_to(classrooms_path) unless @classroom.present?
  end

  def find_classroom
    @classroom = Classroom.find_by(id: params[:id])
  end

  def classrooms_params
    params.require(:classroom).permit(:name, :school_period, :year)
  end
end
