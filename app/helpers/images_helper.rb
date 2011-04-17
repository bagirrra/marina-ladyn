module ImagesHelper
  def get_image_path(collection, image)
    File.join('collections', collection.id.to_s, image.id.to_s + image.file_ext)
  end

  def get_thumb_image_path(collection, image)
    File.join('collections', collection.id.to_s,"thumb" + image.id.to_s + image.file_ext)
  end
end
