class EditMeController < ApplicationController

  def edit
    @update_url = "/edit_me/#{File.join(params[:path])}"
    @content_item = EditMe::ContentItem.new(File.join(params[:path]))
  end

  def activate_revision
    @content_item = EditMe::ContentItem.new(File.join(params[:path]))
    @content_item.activate_revision(params[:revision])
    redirect_to "/edit_me/#{File.join(params[:path])}"
  end

  def edit_mode
    session[:editing] = params[:editing]
    redirect_to "/"
  end
  
  def update
    @content_item = EditMe::ContentItem.new(File.join(params[:path]))
    @content_item.update(params[:content],
      params[:commit_message] || "Edited online")
  end
  
end
