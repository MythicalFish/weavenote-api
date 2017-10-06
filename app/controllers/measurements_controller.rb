class MeasurementsController < ApplicationController

  before_action :set_project

  before_action :check_ability!

  def index
    create_if_none_present
    render json: measurements_response
  end

  def update
    
    m = params[:measurements]

    m[:groups].try(:each_with_index) do |g,i|
      group = @project.measurement_groups.find(g[:id])
      attributes = { name: g[:name] }
      attributes[:order] = i if m[:groups].length > 1
      group.update!(attributes)
    end

    m[:names].try(:each_with_index) do |n,i|
      name = @project.measurement_names.find(n[:id])
      attributes = { value: n[:value] }
      attributes[:order] = i if m[:names].length > 1
      name.update!(attributes)
    end

    m[:values].try(:each) do |v|
      if v[:id]
        value = @project.measurement_values.find(v[:id])
        value.update!(value: v[:value])
      else
        MeasurementValue.create!({
          measurement_group_id: v[:measurement_group_id],
          measurement_name_id: v[:measurement_name_id],
          value: v[:value],
        })
      end
    end

    render json: measurements_response
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
    name = @project.measurement_names.find(params[:id])
    name.destroy!
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
      values: @project.measurement_values!,
    }
  end

  def measurement_group_params
    params.require(:group).permit(:name, :order)
  end

  def measurement_name_params
    params.require(:name).permit(:value, :order)
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