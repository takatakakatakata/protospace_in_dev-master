class PrototypesController < ApplicationController
  before_action :set_prototype, only: :show

  def index
    @prototypes = Prototype.all.includes(:tags)
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
    @prototype.tags.build
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      set_tags
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      redirect_to action: :new, alert: 'YNew prototype was unsuccessfully created'
    end
  end

  def destroy
    protoype = Prototype.find(params[:id])
    protoype.destroy
  end

  def edit
    @prototype = Prototype.find_by(id: params[:id])
  end

  def show
  end

  def update
      prototype = Prototype.find(params[:id])
    if prototype = prototype.update(prototype_params)
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
      captured_images_attributes: [:content, :status],
    )
  end
  def tag_params
    params.require(:prototype).permit(
      tags_attributes: [:tag, :id]
    )
  end
end
