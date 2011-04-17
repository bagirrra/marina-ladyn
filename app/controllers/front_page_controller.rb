class FrontPageController < ApplicationController

  before_filter :authenticate_admin!, :only => [:edit, :update]

  def show
    @front_page = get_front_page
    @slides = Slide.all
  end
  
  def edit
    @front_page = get_front_page
  end
  
  def update
    @front_page = get_front_page
    
    if @front_page.update_attributes(params[:front_page])      
      redirect_to :root, :notice => t("front_page.notices.updated")
    else
      render :edit
    end
  end

  protected
  
  def get_front_page
    FrontPage.first || FrontPage.create
  end
  
end
