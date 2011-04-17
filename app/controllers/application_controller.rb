require "RMagick"

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale
  
  protected
  
  def set_locale
    I18n.locale = params[:locale]
  end
  
  def default_url_options(options = {})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale =>  I18n.locale }    
  end

  def get_collection_path(collection)
    Rails.root.join('public', 'images', 'collections', collection.id.to_s)
  end
  
  def get_image_path(image)
    dir = get_collection_path(image.collection)
    File.join(dir, image.id.to_s + image.file_ext)
  end
  def get_thumb_image_path(image)
    dir = get_collection_path(image.collection)
    File.join(dir, "thumb" + image.id.to_s + image.file_ext)
  end
 
  def save_collection_icon(collection, uploaded_file)
    return if uploaded_file.nil?

    file_name = "icon"
      
    dir = get_collection_path(collection)
    Dir.mkdir(dir) unless File.exists?(dir)
    ext = File.extname(uploaded_file.original_filename)

    tmp_file_path = File.join(dir, "_" + file_name + ext)
    file_path = File.join(dir, file_name + ext)
    File.open(tmp_file_path, 'w') do |f|
      f.write(uploaded_file.read)
    end    

    image = Magick::Image.read(tmp_file_path).first
    File.unlink tmp_file_path

    image.resize_to_fill! 215 * 2,117 * 2
    image.write file_path 
  end

  def save_collection_image(collection, uploaded_file, file_name, add_watermark = true)
    return if uploaded_file.nil?
      
    dir = get_collection_path(collection)
    Dir.mkdir(dir) unless File.exists?(dir)
    ext = File.extname(uploaded_file.original_filename)

    tmp_file_path = File.join(dir, "_" + file_name + ext)
    file_path = File.join(dir, file_name + ext)
    File.open(tmp_file_path, 'w') do |f|
      f.write(uploaded_file.read)
    end    

    watermark_path = File.join(Rails.root, "public", "images", "watermark.png")

    # Crete a thumbnail and watermark the original image
    image = Magick::Image.read(tmp_file_path).first
    File.unlink tmp_file_path
    
    watermark = Magick::Image.read(watermark_path).first
    watermark.resize_to_fit! image.columns

    thumb = image.resize_to_fill 151, 227
    thumb.write File.join(dir, "thumb" + file_name + ext)

    image.composite!(watermark, Magick::SouthGravity, Magick::OverlayCompositeOp)
    image.write file_path
  end
  
  def get_slides_path
    Rails.root.join('public', 'images', 'slides')    
  end
  
  def get_slide_path(slide)
    dir = get_slides_path
    File.join(dir, slide.id.to_s + slide.file_ext)
  end
    
  def save_slide_image(slide)
    dir = get_slides_path
    Dir.mkdir(dir) unless File.exists?(dir)

    tmp_file_path = File.join(dir, "_" + slide.id.to_s + slide.file_ext)
    file_path = File.join(dir, slide.id.to_s + slide.file_ext)
    
    File.open(tmp_file_path, 'w') do |f|
      f.write(slide.uploaded_file.read)
    end 

    image = Magick::Image.read(tmp_file_path).first
    File.unlink tmp_file_path

    image.resize_to_fill! 465, 250
    image.write file_path 
  end      
end
