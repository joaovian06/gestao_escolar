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
    if @classroom.save
      flash[:success] = t('.success')
      redirect_to_index
    else
      flash[:error] = t('.error')
      render(:new)
    end
  end

  def update
    if @classroom.update(classrooms_params)
      flash[:success] = t('.success')
      redirect_to_index
    else
      flash[:error] = t('.error')
      render(:edit)
    end
  end

  def destroy
    if @classroom.present?
      @classroom.destroy
      flash[:success] = t('.success')
    else
      flash[:error] = t('.error')
    end
    redirect_to_index
  end

  private

  def redirect_to_index
    redirect_to(classrooms_path)
  end

  def redirect_index_missing_classroom
    redirect_to_index unless @classroom.present?
  end

  def find_classroom
    @classroom = Classroom.find_by(id: params[:id])
  end

  def classrooms_params
    params.require(:classroom).permit(:name, :school_period, :year, enrollments_attributes: [:id, :student_id ,:_destroy])
  end
end
