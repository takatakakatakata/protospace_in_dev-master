class TagsController < ApplicationController

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def destroy
    prototype = Prototype.includes(:tags).find(params[:prototype_id])
    tag = Tag.find(params[:id])
    prototype.tags.destroy(tag)
    redirect_to prototype_path(params[:prototype_id])
  end

end
