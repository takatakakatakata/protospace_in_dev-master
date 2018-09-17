class CommentsController < ApplicationController
  before_action :set_comment, only:[:destroy,:edit]
  def create
    @comment = Comment.create(comment_params)
    respond_to do |format|
      format.html {redirect_to prototype_path(@comment.prototype)}
      format.json
    end
  end

  def edit
    @prototype = @comment.prototype
  end

  def destroy
    @comment.destroy
    redirect_to root_path, notice: 'コメントを削除しました'
  end

  def update
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to root_path ,notice: 'コメントを編集しました'
    else
      redirect_to action: :edit
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge( prototype_id: params[:prototype_id],user_id: current_user.id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
