class CommentsController < ApplicationController
  
  before_filter :authenticate_admin!, :only => [:edit, :update, :destroy]

  def create
    @image = Image.find(params[:image_id])
    @comment = @image.comments.build(params[:comment])
    
    if @comment.save
      @collection = @image.collection(true)
      redirect_to [@collection, @image], :notice => t("comments.notices.added")
    else
      @collection = @image.collection
      @image.comments.delete(@comment)
      render :template => 'images/show'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @image = @comment.image
    @collection = @image.collection
  end

  def update
    @comment = Comment.find(params[:id])
    @image = @comment.image
    @collection = @image.collection
    
    if @comment.update_attributes(params[:comment])
      redirect_to [@collection, @image], :notice => t("comments.notices.updated")
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @image = @comment.image
    @collection = @image.collection
    @comment.destroy
    
    redirect_to [@collection, @image], :notice => t("comments.notices.deleted")
  end

end
