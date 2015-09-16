class TaskScoresController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_task_score, only: [:show, :edit, :update, :destroy]

  # GET /task_scores
  # GET /task_scores.json
  def index
    @task_scores = current_user.task_scores
  end

  # GET /task_scores/1
  # GET /task_scores/1.json
  def show
  end

  # GET /task_scores/new
  def new
    if session[:task]
      @task_score = TaskScore.new
      @task = Task.find session[:task]
      if current_user.scored_tasks.include?(@task)
        message = t(:task_has_scored) 
        redirect_to courses_url, error: message
      end
    else
      redirect_to task_scores_url, error: t(:no_task_specified)
    end
  end

  # GET /task_scores/1/edit
  def edit
    task = Task.find params[:id]
    if task.close?
      redirect_to :back, error: t(:task_closed)
    end
  end

  # POST /task_scores
  # POST /task_scores.json
  def create
    task = Task.find session[:task]
    if session[:task] && task
      @task_score = TaskScore.new(task_score_params)
      @task_score.user = current_user
      @task_score.task = task
    else
      redirect_to :back, error: t(:no_task_specified)
    end

    respond_to do |format|
      if @task_score.save
        format.html { redirect_to @task_score, notice: t(:task_score_create_success)}
        format.json { render action: 'show', status: :created, location: @task_score }
      else
        format.html { render action: 'new' }
        format.json { render json: @task_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_scores/1
  # PATCH/PUT /task_scores/1.json
  def update
    respond_to do |format|
      if @task_score.update(task_score_params)
        format.html { redirect_to @task_score, notice: t(:task_score_update_success)}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_scores/1
  # DELETE /task_scores/1.json
  def destroy
    @task_score.destroy
    respond_to do |format|
      format.html { redirect_to task_scores_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_score
      @task_score = TaskScore.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_score_params
      params.require(:task_score).permit(:score, :content, :user_id, :task_id)
    end
end
