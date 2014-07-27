class HousesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_action :set_house, only: [:show, :edit, :update, :destroy]

  # GET /houses
  # GET /houses.json
  def index
    if session[:city]
      houses = House.where city: session[:city]
      @districts = houses.pluck(:district).uniq
      if session[:district]
        @houses = houses.where district: session[:district]
      else
        @houses = houses
      end
    else
      @houses = House.where status: 'open'
    end
  end

  # GET /houses/1
  # GET /houses/1.json
  def show
  end

  # GET /houses/new
  def new
    @house = House.new
  end

  # GET /houses/1/edit
  def edit
  end

  # POST /houses
  # POST /houses.json
  def create
    @house = House.new(house_params)
    @house.user = current_user if @house.user.nil?

    respond_to do |format|
      if @house.save
        format.html { redirect_to @house, notice: t('house_create_success') }
        format.json { render action: 'show', status: :created, location: @house }
      else
        format.html { render action: 'new' }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /houses/1
  # PATCH/PUT /houses/1.json
  def update
    respond_to do |format|
      if @house.update(house_params)
        format.html { redirect_to @house, notice: t('house_update_success') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /houses/1
  # DELETE /houses/1.json
  def destroy
    @house.destroy
    respond_to do |format|
      format.html { redirect_to houses_url }
      format.json { head :no_content }
    end
  end

  def open
    @house = House.find params[:id]
    if @house.albums.length > 0 and @house.publish
      redirect_to :back, notice: 'success'
    else
      redirect_to :back, notice: 'failed'
    end
  end

  def close
    @house = House.find params[:id]
    @house.close
    if @house.save
      redirect_to :back, notice: 'success'
    else
      redirect_to :back, notice: 'failed'
    end
  end

  def checkin
    @house = House.find params[:id]
    @house.checkin
    if @house.save
      redirect_to :back, notice: 'success'
    else
      redirect_to :back, notice: 'failed'
    end
  end

  def checkout
    @house = House.find params[:id]
    @house.checkout
    if @house.save
      redirect_to :back, notice: 'success'
    else
      redirect_to :back, notice: 'failed'
    end
  end

  def list_city
    if params[:city]
      city = params[:city]
      session[:city] = city + t("city_suffix")
      session[:district] = nil
    end
    redirect_to houses_path
  end

  def list_district
    session[:district] = params[:region]
    redirect_to houses_path
  end

  def search(keyword)
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_house
      @house = House.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def house_params
      facility = params[:house][:facility]
      params[:house][:facility] = facility.nil? ? "" : facility.join(" ")
      params.require(:house).permit(:identifier, :name, :region, :address, :house_type, :area, :floor, :floor_type, :capacity, :bed, :direction, :status, :user_id, :facility, :longitude, :latitude, :album_ids => [])
    end
end
