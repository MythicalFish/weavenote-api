class AnnotationsController < ApplicationController

  before_action :set_annotatable!
  before_action :authorize_annotation!
  before_action :set_annotation, except: [:create]

  def create
    @annotatable.annotations.destroy_all
    @annotation = @annotatable.annotations.create!(annotation_params)
    render_success "Annotation created", serialized(@annotation.image)
  end

  def destroy
    @annotation.destroy!
    render_success "Annotation deleted"
  end

  def update
    @annotation.update!(annotation_params)
    render_success "Annotation updated", serialized(@annotation)
  end

  private

  def annotation_params
    p = params[:annotation]
    p[:anchors_attributes] = params[:anchors]
    p[:annotation_type] = params[:type]
    p.permit(
      :image_id, :annotation_type, 
      anchors_attributes: [:x, :y]
    )
  end

  def set_annotatable!
    a = params[:annotatable]
    annotatable_class = Object.const_get(a[:type])
    @annotatable = annotatable_class.find(a[:id])
    raise "Missing annotatable" unless @annotatable
  end

  def authorize_annotation!
    case @annotatable.class.name
    when 'Comment'
      raise "Comment not owned by user" unless @annotatable.user == @user
    when 'MeasurementName'
      # ability check performed by CheckAbility
    else
      raise "Invalid Annotatable"
    end
  end

  def set_annotation
    @annotation = @annotatable.annotations.find(params[:id])
  end

end
