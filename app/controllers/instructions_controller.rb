class InstructionsController < ApplicationController
  
  before_action :set_project
  before_action :set_instruction, only: [:show, :update, :destroy]

  # GET /projects/:project_id/instructions
  def index
    @instructions = @project.instructions.order('id DESC')
    render json: @instructions
  end

  # GET /projects/:project_id/instructions/:id
  def show
    render json: @instruction
  end

  # POST /projects/:project_id/instructions
  def create
    @instruction = @project.instructions.new(instruction_params)
    if @instruction.save
      render json: @instruction, status: :created
    else
      render json: @instruction.errors.full_messages.join(', '), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/:project_id/instructions/:id
  def update
    if @instruction.update(instruction_params)
      render json: @instruction
    else
      render json: @instruction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/:project_id/instructions/:id
  def destroy
    @instruction.destroy
    index
  end

  private

  def set_project
    @project = @user.projects.find(params[:project_id])
  end

  def set_instruction
    @instruction = @project.instructions.find(params[:id])
  end

  def instruction_params
    params.require(:instruction).permit(:quantity, :material_id)
  end

end
