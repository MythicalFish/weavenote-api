class AnnotationsController < ApplicationController

  before_action :set_associations
  before_action :set_annotation, except: [:create]
  before_action :check_ability!

  def create
    @image.annotations.create!(create_annotation_params)
    render_success "Annotation created", annotations_response
  end

  def update
    @annotation.update!(update_annotation_params)
    render_success "Annotation updated", annotations_response
  end  
  
  def destroy    
    @annotation.destroy!
    render_success "Annotation deleted", annotations_response
  end

  private

  def create_annotation_params
    p = params[:annotation]
    p[:user_id] = @user.id
    p.permit(
      :user_id, :image_id, :annotation_type, 
      :annotatable_id, :annotatable_type,
      anchors_attributes: [:x, :y]
    )
  end

  def update_annotation_params
    params.require(:annotation).permit(
      anchors_attributes: [:id, :x, :y]
    )
  end

  def set_associations
    @image = @organization.images.find(params[:annotation][:image_id])
    @project = @image.imageable
  end

  def set_annotation
    @annotation = @image.annotations.find(params[:id])
  end

  def annotations_response
    serialized(@image.annotations)
  end

end
