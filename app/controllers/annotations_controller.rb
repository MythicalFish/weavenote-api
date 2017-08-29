class AnnotationsController < ApplicationController

  before_action :set_project
  before_action :set_annotatable
  before_action :set_annotation, except: [:create]

  def create
    @annotatable.annotations.destroy_all
    @annotation = @annotatable.annotations.create!(annotation_params)
    render_success "Annotation created", serialized(@annotation.image)
  end

  def destroy
    @annotatable.annotations.find(params[:id])
    render_success "Annotation deleted"
  end

  private

  def annotation_params
    params.require(:annotation).permit(
      :image_id, :annotation_type, 
      :annotatable_id, :annotatable_type,
      anchors_attributes: [:x, :y]
    )
  end

  def set_annotatable
    p = annotation_params
    klass = Object.const_get(p[:annotatable_type])
    @annotatable = klass.find(p[:annotatable_id])
    raise "Missing annotatable" unless @annotatable
    case @annotatable.class.name
    when 'Comment'
      raise "Comment not owned by user" unless @annotatable.user == @user
    when 'MeasurementName'
      check_ability!
    else
      raise "Invalid Annotatable"
    end
  end

  def set_project
    @project = @annotatable.try(:project)
  end

end
