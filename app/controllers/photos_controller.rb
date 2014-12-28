class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /photos
  # GET /photos.json
  def index
    @album = Album.find_by id: params[:album_id], user_id: current_user
    if @album.nil?
      redirect_to albums_path 
    else
      @photos = @album.photos
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        #format.json { render action: 'show', status: :created, location: @photo }
        #format.html {  
          #render :json => [@photo.to_fileupload].to_json, 
          #:content_type => 'text/html',
          #:layout => false
        #}
        format.json { render json: {files:[@photo.to_fileupload]}, status: :created, location: @upload }
      else
        format.html { render action: 'new' }
        format.json { render json: [{error: @photo.errors}], status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to edit_photo_path(@photo), notice: 'Photo was successfully updated.' }
        format.json { render json: {files: [@photo.to_fileupload]}, status: :created }
      else
        format.html { render action: 'edit' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:album_id, :title, :image, :description, :remove_image)
    end
end
