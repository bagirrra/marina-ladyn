class UsersController < ApplicationController

  before_filter :authenticate_admin!

  def index
    @users = Admin.all  
  end

  def new
    @user = Admin.new 
  end

  def create
    @user = Admin.new(params[:user]) 

    if @user.save
      redirect_to users_path, :notice => t("users.notices.added")
    else
      render :new
    end
  end

  def edit
    @user = Admin.find(params[:id])  
  end

  def update
    @user = Admin.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to users_path, :notice => t("users.notices.updated")
    else
      render :edit
    end
  end

  def destroy
    @user = Admin.find(params[:id])

    if current_admin != @user
      @user.destroy
      redirect_to users_path, :notice => t("users.notices.destroyed")
    else
      redirect_to users_path, :notice => t("users.notices.cant_destroy_yourself")
    end
  end
end
