class SlidesController < ApplicationController
 
  before_filter :authenticate_admin!

  def index
    @slides = Slide.all
  end
  
  def new
    @slide = Slide.new
  end
  
  def create
    @slide = Slide.new(params[:slide])
    
    if @slide.save
      save_slide_image(@slide)
      redirect_to slides_path, :notice => t("slides.notices.added")
    else
      render :new
    end
  end
  
  def edit
    @slide = Slide.find(params[:id])
  end
  
  def update
    @slide = Slide.find(params[:id])
    
    if @slide.update_attributes(params[:slide])
      save_slide_image(@slide)
      redirect_to slides_path, :notice => t("slides.notices.updated")
    else
      render :edit
    end
  end
  
  def destroy
    @slide = Slide.find(params[:id])
    @slide.destroy
    File.unlink(get_slide_path(@slide))    
    redirect_to slides_path, :notice => t("slides.notices.deleted")
  end
  
end
