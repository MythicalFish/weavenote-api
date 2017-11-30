class AnnotationsController < ApiController

  before_action :set_associations, except: [:index]
  before_action :set_annotation, except: [:index, :create]
  before_action :check_ownership_or_ability

  def index
    @project = @organization.projects.find(params[:project_id])
    render json: annotations_response
  end

  def create
    @image.annotations.create!(create_annotation_params)
    render json: annotations_response
  end

  def update
    @annotation.update!(update_annotation_params)
    render json: annotations_response
  end  
  
  def destroy    
    @annotation.update!(archived: true)
    render json: annotations_response
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
    serialized(@project.annotations.active)
  end

  def is_own_annotation?
    @annotation.user == @user
  end

  def check_ownership_or_ability
    if action_name == 'update'
      # Only owner can edit comment
      deny! unless is_own_annotation?
    elsif action_name == 'destroy'
      # Only owner or admin can delete (archived)
      deny! unless is_own_annotation? || @user.is_admin? || @user.is_member
    else
      check_ability!
    end
  end

end
