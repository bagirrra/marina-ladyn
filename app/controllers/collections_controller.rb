require 'fileutils'

class CollectionsController < ApplicationController

  before_filter :authenticate_admin!, :only => [:new, :create, :edit, :update, :destroy]


  def index
    #@collections = Collection.where(:group => 'Collections')
    @collections = get_collections 
  end
  
  def our_clients    
    @collection = get_client_collection 
    @images = get_collection_images(@collection.id)
    render :show
  end
  
  def show
    @collection = Collection.find(params[:id])
    @images = get_collection_images(@collection.id)
  end
  
  def new
    @collection = Collection.new
  end
  
  def create
    @collection = Collection.create(params[:collection])
        
    if @collection.valid?
      save_collection_icon(@collection, @collection.uploaded_icon)
      redirect_to collections_path, :notice => t("collections.notices.created")
    else
      render :new
    end
  end
  
  def edit
    @collection = Collection.find(params[:id])
  end
  
  def update
    @collection = Collection.find(params[:id])
    
    if @collection.update_attributes(params[:collection])
        save_collection_icon(@collection, @collection.uploaded_icon)
        redirect_to collections_path, :notice => t("collections.notices.updated")
    else
      render :new
    end
  end
  
  def destroy
    @collection = Collection.find(params[:id])
    @collection.destroy
    
    dir = get_collection_path(@collection)
    FileUtils.rm_rf(dir)
    
    redirect_to collections_path, :notice => t("collections.notices.deleted")
  end
  
  private
  
  def get_client_collection
    collection = Collection.find_by_group('ClientCollection')
    
    if collection.nil?
      fake_class = Class.new do
        attr_accessor :original_filename
      end
      
      fake_image = fake_class.new
      fake_image.original_filename = 'fake.jpg'
      
      collection = Collection.create(
        :name_ru => "Наши невесты",
        :name_en => "Our brides",
        :name_de => "",
        :uploaded_icon => fake_image, 
        :group => 'ClientCollection')
    end
    
    return collection
  end
  
  def get_collections
    Collection.paginate 'Collections', :finder => 'find_all_by_group',
      :page => params[:page], :per_page => 4
  end

  def get_collection_images(collection_id)
    Image.paginate collection_id, :finder => 'find_all_by_collection_id',  
      :page => params[:page], :per_page => 12
  end
end
