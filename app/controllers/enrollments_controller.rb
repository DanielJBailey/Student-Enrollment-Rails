class EnrollmentsController < ApplicationController
  before_action :set_course
  def index
    @tas = @course.enrollments.where(role: "ta")
    @teachers = @course.enrollments.where(role: "teacher")
    @students = @course.enrollments.where(role: "student")
  end

  def new
    @enrollment = @course.enrollments.new
  end

  def create
    @enrollment = @course.enrollments.new(enrollment_params)
    if @enrollment.save
      redirect_to course_enrollments_path(@course)
    else
      render :new
    end
  end

  def destroy
    @course.enrollments.find(params[:id]).destroy
    # redirect_to course_users_path
  end

  private
    def set_course
      @course = Course.find(params[:course_id])
    end

    def enrollment_params
      params.require(:enrollment).permit(:role, :user_id)
    end
end
