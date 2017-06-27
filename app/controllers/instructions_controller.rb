class InstructionsController < ApplicationController
  
  before_action :set_project
  before_action :set_instruction, only: [:show, :update, :destroy]

  def index
    @instructions = @project.instructions.order('id DESC')
    render json: @instructions
  end

  def show
    render json: @instruction
  end

  def create
    @instruction = @project.instructions.new(instruction_params)
    @instruction.save!
    render json: @instruction, status: :created
  end

  def update
    @instruction.update!(instruction_params)
    render json: @instruction
  end

  def destroy
    @instruction.destroy!
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
    params.require(:instruction).permit(:title, :description)
  end

end
