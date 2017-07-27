class AnnotationsController < ApplicationController

  before_action :set_annotatable
  before_action :set_annotation, except: [:create]

  def create
    @annotation = @annotatable.annotations.create!(annotation_params)
    render_success "Annotation created", annotations_response
  end

  def destroy
    @annotation.destroy!
    render_success "Annotation deleted", annotations_response
  end

  def update
    @annotation.update!(annotation_params)
    render_success "Annotation updated", annotations_response
  end

  private

  def annotation_params
    p = params[:annotation]
    p[:anchors_attributes] = params[:anchors]
    p[:annotation_type] = params[:type]
    p.permit(:image_id, :anchors_attributes, :annotation_type)
  end

  def set_annotatable
    a = params[:annotatable]
    annotatable_class = Object.const_get(a[:type])
    @annotatable = annotatable_class.find(a[:id])
    raise "Missing annotatable" unless @annotatable
    raise "Annotatable not owned by user" unless @annotatable.user == @user
  end

  def set_annotation
    @annotation = @annotatable.annotations.find(params[:id])
  end

  def annotations_response
    annotations = @annotatable.annotations
    return { annotations: annotations, annotatable: { id: @annotatable.id, type: @annotatable.class.name } }
  end

end
