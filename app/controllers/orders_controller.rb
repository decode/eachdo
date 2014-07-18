class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = current_user.orders
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    session[:house_id] = params[:house_id] if params[:house_id]
    @house = House.find params[:house_id]
    if @house.can_order?
      @order = Order.new
    else
      redirect_to :back, alert: t('house_not_open')
    end
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    #@order = Order.new(order_params)
    @house = House.find session[:house_id]
    @order = @house.orders.new(order_params)
    @order.user = current_user
    @order.price = @house.total_price(@order.from, @order.to)

    respond_to do |format|
      if @house.can_order?(from: @order.from, to: @order.to) and @order.book and @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { redirect_to new_house_order_url(@house), alert: 'Can not create order' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    @order.price = @order.house.total_price(@order.from, @order.to)
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  def confirm
    @order = Order.find params[:id]
    if @order.confirm
      redirect_to :back, notice: 'success'
    else
      redirect_to :back, notice: 'failed'
    end
  end

  def pay
    @order = Order.find params[:id]
    if @order.pay
      redirect_to :back, notice: 'success'
    else
      redirect_to :back, notice: 'failed'
    end
  end

  def cancel
    @order = Order.find params[:id]
    if @order.cancel
      redirect_to :back, notice: 'success'
    else
      redirect_to :back, notice: 'failed'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:house_id, :user_id, :from, :to, :price, :deposit, :payment, :name, :phone, :is_oneself)
    end
end
