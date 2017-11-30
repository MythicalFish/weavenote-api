class SuppliersController < ApiController
  
  before_action :set_supplier, only: [:destroy]
  
  before_action :check_ability!

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
