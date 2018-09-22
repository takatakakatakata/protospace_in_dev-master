class PrototypesController < ApplicationController
  before_action :set_prototype, only: :show
  def index
    @prototypes = Prototype.all.includes(:tags).page(params[:page]).per(7)
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
    @prototype.tags.build
  end

  def popular
    @prototypes = Prototype.includes(:user).page(params[:page]).per(10).order('likescount DESC')
    respond_to do |format|
      format.html
      format.json
    end
  end

  def newest
    @prototypes = Prototype.includes(:user).page(params[:page]).per(10).order('created_at DESC')
    respond_to do |format|
      format.html
      format.json
    end
  end

  def popular
    @prototypes = Prototype.includes(:user).page(params[:page]).order('likescount DESC')
    respond_to do |format|
      format.html
      format.json
    end
  end

  def newest
    @prototypes = Prototype.includes(:user).page(params[:page]).order('created_at DESC')
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @prototype = Prototype.new(prototype_params)

    if @prototype.save
      set_tags
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
    prototype = Prototype.find(params[:id])
    if prototype = prototype.update(all_params)
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      redirect_to action: :edit, alert: 'YNew prototype was unsuccessfully created'
     end
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def set_tags
    new_tags = tag_params.to_h
    @tags = new_tags[:tags_attributes].values
      @tags.each do |tag|
        if tag[:tag].present?
          add_tag = Tag.find_or_create_by(tag: "#{tag[:tag]}")
          @prototype.tags << add_tag
        end
      end
  end

  def prototype_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:id, :content, :status],
    )
  end
  def tag_params
    params.require(:prototype).permit(
      tags_attributes: [:tag, :id]
    )
  end
  def all_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:id, :content, :status],
      tags_attributes: [:tag, :id]
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
