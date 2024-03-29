class InstructionsController < ApiController
  
  before_action :set_project
  before_action :set_instruction, only: [:show, :update, :destroy]

  before_action :check_ability!

  def index
    render json: list
  end

  def show
    render json: @instruction
  end

  def create
    @instruction = @project.instructions.create!(instruction_params)
    render_success "Instruction created", serialized(list)
  end

  def update
    @instruction.update!(instruction_params)
    render_success "Instruction updated", serialized(list)
  end
  
  def destroy
    @instruction.destroy!
    render_success "Instruction deleted", serialized(list)
  end

  private

  def list
    @project.instructions.order('id DESC')
  end

  def set_project
    @project = @user.projects.find(params[:project_id])
  end

  def set_instruction
    @instruction = @project.instructions.find(params[:id])
  end

  def instruction_params
    params.require(:instruction).permit(:title, :description, :image_ids => [])
  end

end
