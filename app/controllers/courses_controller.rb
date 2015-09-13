class CoursesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource except: :filter

  def filter
    if current_user.team.nil? && current_user.has_role?(:student)
      redirect_to teams_url, notice: "请先选择所属班级"
    else
      session[:course_type] = params[:id]
      redirect_to courses_path
    end
  end

  # GET /courses
  # GET /courses.json
  def index
    filter = session[:course_type]
    if current_user
      case filter
      when 'selected'
        @courses = current_user.study_courses
      when 'all'
        @courses = Course.where(school_id: current_user.school_id)
      when 'teached'
        @courses = current_user.courses
      else
        @courses = Course.all
      end
    else
      @courses = Course.all
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: t(:course_create_success) }
        format.json { render action: 'show', status: :created, location: @course }
      else
        format.html { render action: 'new' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: t(:course_update_success) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end

  def join
    course = Course.find params[:id]
    if course && course.status == 'open'
      course.students.append current_user 
      redirect_to courses_url, notice: "选课成功"
    else
      redirect_to courses_url, error: "课程未开放,无法加入"
    end
  end

  def open
    course = Couse.find params[:id]
    course.status = "open" if course
    redirect_to :back
  end

  def close
    course = Couse.find params[:id]
    course.status = "close" if course
    redirect_to :back
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:cid, :name, :status, :description, :term, :user_id, :school_id)
    end
end
