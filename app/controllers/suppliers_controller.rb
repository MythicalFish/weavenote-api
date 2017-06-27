class SuppliersController < ApplicationController
  
  before_action :set_supplier, only: [:destroy]

  def index
    @suppliers = @organization.suppliers.order('id DESC')
    render json: @suppliers
  end

  def destroy
    @supplier.destroy!
    index
  end

  private

  def set_supplier
    @supplier = @organization.suppliers.find(params[:id])
  end

end
