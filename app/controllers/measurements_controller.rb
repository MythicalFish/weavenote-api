class MeasurementsController < ApplicationController
  
  before_action :set_project

  # GET /projects/:id/measurements
  def index
    render json: {
      groups: @project.measurement_groups,
      names: @project.measurement_names,
      values: @project.measurement_values!
    }
  end

  # PATCH /projects/:id/measurements
  def update
    
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

  # POST /projects/:id/measurement_groups
  def create_group
    @group = @project.measurement_groups.new(measurement_group_params)
    if @group.save
      index
    else 
      render json: @group.errors.full_messages.join(', '), status: :unprocessable_entity
    end
  end

  # POST /projects/:id/measurement_names
  def create_name
    @name = @project.measurement_names.new(measurement_name_params)
    if @name.save
      index
    else 
      render json: @name.errors.full_messages.join(', '), status: :unprocessable_entity
    end
  end

  private

  def measurement_group_params
    params.require(:group).permit(:name)
  end

  def measurement_name_params
    params.require(:name).permit(:value)
  end

  def set_project
    @project = @user.projects.find(params[:project_id])
  end

end