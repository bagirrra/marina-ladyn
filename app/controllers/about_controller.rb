class AboutController < ApplicationController
 
  before_filter :authenticate_admin!, :only => [:edit, :update]

  def show
    @about = get_about
  end

  def edit
    @about = get_about
  end

  def update
    @about = About.find_by_locale(I18n.locale.to_s)

    if @about.update_attributes(params[:about])
      redirect_to about_path, :notice => t("about.notices.updated")
    else
      render :edit
    end
  end

  protected

  def get_about
    about = About.find_by_locale(I18n.locale.to_s)

    if about.nil?
      about = About.create(:locale => I18n.locale.to_s)
    end

    return about
  end

end
