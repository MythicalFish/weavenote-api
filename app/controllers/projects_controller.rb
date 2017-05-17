class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy, :material_cost, :measurements, :update_measurements]

  # GET /projects
  def index
    archived = params[:archived] == "true" ? true : false
    @projects = @user.projects
      .order('created_at DESC')
      .where(archived: archived)
    render json: @projects
  end

  # GET /projects/:id
  def show
    render json: @project
  end

  # POST /projects
  def create
    @project = @user.projects.new(project_params)
    if @project.save
      #render json: @project, status: :created, location: @project
      index
    else
      render json: @project.errors.full_messages.join(', '), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/:id
  def update
    if @project.update(project_params)
      if params[:index_after_update]
        index
      else 
        render json: @project
      end
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/:id
  def destroy
    @project.destroy
  end

  # GET /projects/:id/material_cost
  def material_cost
    render json: @project.material_cost
  end

  # GET /projects/:id/measurements
  def measurements
    render json: {
      groups: @project.measurement_groups,
      names: @project.measurement_names,
      values: @project.measurement_values!
    }
  end

  # PATCH /projects/:id/measurements
  def update_measurements
    
    @m = params[:measurements]
    @errors = []
    @updates = { groups: [], names: [], values: [] }

    @m[:groups].each do |g|
      group = @project.measurement_groups.find(g[:id])
      next if g[:name] == group.name
      if group.update({ name: g[:name] })
        @updates[:groups] << group
      else
        @errors << group.errors
      end
    end

    @m[:names].each do |n|
      name = @project.measurement_names.find(n[:id])
      next if n[:value] == name.value
      if name.update({ value: n[:value] })
        @updates[:names] << name
      else
        @errors << name.errors
      end
    end

    @m[:values].each do |v|
      value_value = 0
      if v[:id]
        value_value = @project.measurement_values.find(v[:id]).value
      end
      value_changed = value_value != v[:value]
      if value_changed
        new_value_attributes = {
          measurement_group_id: v[:measurement_group_id],
          measurement_name_id: v[:measurement_name_id],
          value: v[:value],
        }
        value = MeasurementValue.new(new_value_attributes)
        if value.save
          @updates[:values] << value
        else
          @errors << value.errors
        end
      end
    end

    render json: {
      errors: @errors,
      updates: @updates,
      measurements: {
        groups: @project.measurement_groups,
        names: @project.measurement_names,
        values: @project.measurement_values!
      }
    }
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = @user.projects.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(
        :name, :identifier, :archived, :images, :description,
        :development_stage_id, :category
      )
    end
end
