class MeasurementsController < ApplicationController

  before_action :set_project

  before_action :check_ability!

  def index
    create_if_none_present
    render json: measurements_response
  end

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
      value_value = nil
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

    render_success "Measurement updated", measurements_response
  end

  def create_group 
    check_ability! :create, 'Measurement'
    if @project.measurement_groups.length >= 15
      render_error "Maximum measurement groups is 15"
    end
    @group = @project.measurement_groups.create!
    render_success "Measurement group created", measurements_response
  end

  def create_name
    check_ability! :create, 'Measurement'
    if @project.measurement_groups.length >= 26
      render_error "Maximum measurement names is 26"
    end    
    @name = @project.measurement_names.create!
    render_success "Measurement name created", measurements_response
  end

  def delete_name
    check_ability! :destroy, 'Measurement'
    n = @project.measurement_names.find(params[:id])
    n.destroy!
    render_success "Measurement name deleted", measurements_response
  end

  def delete_group
    check_ability! :destroy, 'Measurement'
    n = @project.measurement_groups.find(params[:id])
    n.destroy!
    render_success "Measurement group deleted", measurements_response
  end


  private

  def measurements_response
    {
      groups: @project.measurement_groups,
      names: serialized(@project.measurement_names),
      values: @project.measurement_values!
    }
  end

  def measurement_group_params
    params.require(:group).permit(:name)
  end

  def measurement_name_params
    params.require(:name).permit(:value)
  end

  def set_project
    @project = @user.projects.find(params[:project_id])
  end

  def create_if_none_present
    unless @project.measurement_groups.any? || @project.measurement_names.any?
      @project.measurement_groups.create!
      10.times { @project.measurement_names.create! }
    end
  end

end