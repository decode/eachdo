class FeedbacksController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]

  def filter
    session[:feedback_type] = params[:id]
    redirect_to feedbacks_path
  end

  # GET /feedbacks
  # GET /feedbacks.json
  def index
    if session[:feedback_type] == 'feedback_from'
      @feedbacks = current_user.received_feedbacks.paginate page: params[:page]
    else
      @feedbacks = current_user.feedbacks.paginate page: params[:page]
    end
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
  end

  # GET /feedbacks/new
  def new
    @feedback = Feedback.new
    session[:order_id] = params[:order_id] if params[:order_id]
    @order = Order.find params[:order_id]
    redirect_to :back, alert: 'order not exists' unless @order
  end

  # GET /feedbacks/1/edit
  def edit
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @order = Order.find session[:order_id]
    @feedback = Feedback.new(feedback_params)
    @feedback.order = @order
    @feedback.house = @order.house
    @feedback.user = current_user

    respond_to do |format|
      if @feedback.save
        format.html { redirect_to @feedback, notice: t('feedback_create_success') }
        format.json { render action: 'show', status: :created, location: @feedback }
      else
        format.html { render action: 'new' }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feedbacks/1
  # PATCH/PUT /feedbacks/1.json
  def update
    respond_to do |format|
      if @feedback.update(feedback_params)
        format.html { redirect_to @feedback, notice: t('feedback_update_success') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.json
  def destroy
    @feedback.destroy
    respond_to do |format|
      format.html { redirect_to feedbacks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feedback_params
      params.require(:feedback).permit(:house_id, :order_id, :title, :comment, :rating, :judgement)
    end
end
