class AlbumsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /albums
  # GET /albums.json
  def index
    @albums = current_user.albums.paginate page: params[:page]
  end

 # GET /albums/1
  # GET /albums/1.json
  def show
  end

  # GET /albums/new
  def new
    @album = Album.new
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(album_params)
    @album.user = current_user

    respond_to do |format|
      if @album.save
        if params[:images]
          params[:images].each do |image|
            @album.photos.create(image: image)
          end
        end
        #format.html { redirect_to edit_album_path(@album), notice: 'Album was successfully created.' }
        format.html { redirect_to new_house_path, notice: t('album_create_success') }
        format.json { render action: 'show', status: :created, location: @album }
      else
        format.html { render action: 'new' }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        notice = t('album_update_success')
        if params[:images] and @album.can_upload_photo?
          params[:images].each do |image|
            @album.photos.create(image: image)
          end
        else
          notice = notice + ". " + t('album_photo_full')
        end
        format.html { redirect_to edit_album_path(@album), notice: notice }
        #format.json { head :no_content }
        format.json { render action: 'edit', status: :created, location: @album }
      else
        format.html { redirect_to edit_album_path(@album), alert: t('album_update_failed') }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:title, :description, :user_id)
    end
end
