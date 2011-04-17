module SlidesHelper
  def get_slide_path(slide)
    File.join('slides', slide.id.to_s + slide.file_ext)
  end  
end
