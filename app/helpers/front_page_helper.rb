module FrontPageHelper
  def slide_url(slide)
    "/images/slides/#{slide.id.to_s + slide.file_ext}"
  end
end
