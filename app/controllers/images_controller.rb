class ImagesController < ApplicationController
 
  before_filter :authenticate_admin!, :only => [:new, :create, :edit, :update, :destroy]

  def index
    redirect_to collection_path(params[:locale], params[:collection_id])
  end
  
  def show
    @image = Image.find(params[:id])
    @collection = @image.collection
    @comment = Comment.new
  end

  def new
    @collection = Collection.find(params[:collection_id])
    @image = @collection.images.build
  end

  def create
    @collection = Collection.find(params[:collection_id])
    @image = @collection.images.build(params[:image])
    
    if @image.save
      save_collection_image(@collection, @image.uploaded_file, @image.id.to_s)
      redirect_to @collection, :notice => t("images.notices.added")
    else
      render :new
    end    
  end

  def edit
    @image = Image.find(params[:id])    
    @collection = @image.collection
  end

  def update
    @image = Image.find(params[:id])
    @collection = @image.collection


    if @image.update_attributes(params[:image])
      save_collection_image(@collection, @image.uploaded_file, @image.id.to_s)
      redirect_to @collection, :notice => t("images.notices.updated")
    else
      render :edit
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    
    # small and big images must be deleted!
    File.unlink(get_image_path(@image)) if File.exists?(get_image_path(@image))
    File.unlink(get_thumb_image_path(@image)) if File.exists?(get_thumb_image_path(@image))
    
    redirect_to @image.collection, :notice => t("images.notices.deleted")
  end

end
