class PrototypesController < ApplicationController
  before_action :set_prototype, only: :show
  PER = 10
  def index
    @prototypes = Prototype.all.page(params[:page]).per(PER)
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
  end

  def popular
    @prototypes = Prototype.includes(:user).page(params[:page]).per(PER).order('likescount DESC')
    respond_to do |format|
      format.html
      format.json
    end
  end

  def newest
    @prototypes = Prototype.includes(:user).page(params[:page]).per(PER).order('created_at DESC')
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @prototype = Prototype.new(prototype_params)

    if @prototype.save
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      redirect_to action: :new, alert: 'New prototype was unsuccessfully created'
     end
  end

  def destroy
    protoype = Prototype.find(params[:id])
    protoype.destroy
  end

  def edit
    @prototype = Prototype.find_by(id: params[:id])
    @prototype.captured_images.find_by(id: params[:id])
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def update
      @prototype = Prototype.find(params[:id])
    if @prototype.update_attributes(update_prototype_params)
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      redirect_to action: :edit, alert: 'YNew prototype was unsuccessfully created'
     end
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:content, :status]
    )
  end

    def update_prototype_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:id, :content, :status]
    )
  end

end
