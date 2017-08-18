class StaticResourcesController < ApplicationController

  def colors
    @colors = Color.all.order('name ASC')
    render json: @colors
  end

  def material_types
    @types = MaterialType.all.order('name ASC')
    render json: @types
  end

  def currencies
    @currencies = Currency.all
    render json: @currencies
  end

  def care_labels
    @labels = CareLabel.all
    render json: @labels
  end

  def role_types
    r = []
    RoleType.permitted.each do |rt|
      r << rt.attributes
    end
    render json: r
  end


end
