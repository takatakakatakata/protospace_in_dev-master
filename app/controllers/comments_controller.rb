class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    redirect_to controller: :prototypes, action: :index
  end

  def edit
  end 

  def destroy 
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge( prototype_id: params[:prototype_id],user_id: current_user.id)
  end

end
