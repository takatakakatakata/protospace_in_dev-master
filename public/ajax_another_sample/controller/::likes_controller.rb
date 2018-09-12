class LikesController < ApplicationController

before_action :set_variable

def like
  @like = current_user.likes.new(prototype_id: @prototype.id)
  @likes = Like.where(prototype_id: params[:prototype_id])
  @like.save
end


def unlike
  @like = current_user.likes.find_by(prototype_id: @prototype.id)
  @like.destroy

  @likes = Like.where(prototype_id: params[:prototype_id])
  @prototype.reload
end

private
def set_variable
  @prototype = Prototype.find(params[:prototype_id])
  @id_name = "#like-link-#{@prototype.id}"
  @id_heart = "#heart-#{@prototype.id}"
end

end
