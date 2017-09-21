class AnnotationsController < ApplicationController

  before_action :set_associations
  before_action :check_ability!

  def create
    if @annotatable
      @annotatable.annotations.destroy_all # One annotation per comment or measurement
      @annotation = @annotatable.annotations.create!(annotation_params)
    else
      @image.annotations.create!(annotation_params)
    end
    render_success "Annotation created", serialized(@image)
  end

  def destroy
    @annotatable.annotations.find(params[:id])
    render_success "Annotation deleted"
  end

  private

  def annotation_params
    p = params[:annotation]
    p[:user_id] = @user.id
    p.permit(
      :user_id, :image_id, :annotation_type, 
      :annotatable_id, :annotatable_type,
      anchors_attributes: [:x, :y]
    )
  end
  
  def set_associations
    @image = @organization.images.find(params[:annotation][:image_id])
    @project = @image.imageable
    set_annotatable
  end

  # Legacy
  def set_annotatable
    p = annotation_params
    return nil unless p[:annotatable_type]
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

end
