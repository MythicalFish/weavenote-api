class SuppliersController < ApplicationController
  
  before_action :set_supplier, only: [:show, :update, :destroy]

  # GET /suppliers
  def index
    @suppliers = @user.suppliers.order('id DESC')
    render json: @suppliers
  end

  # GET /suppliers/:id
  def show
    render json: @supplier
  end

  # POST /suppliers
  def create
    @supplier = @user.suppliers.new(supplier_params)
    if @supplier.save
      render json: @supplier, status: :created
    else
      render json: @supplier.errors.full_messages.join(', '), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /suppliers/:id
  def update
    if @supplier.update(supplier_params)
      render json: @supplier
    else
      render json: @supplier.errors, status: :unprocessable_entity
    end
  end

  # DELETE /suppliers/:id
  def destroy
    @supplier.destroy
    index
  end

  private

  def set_supplier
    @supplier = @user.suppliers.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(:title, :description)
  end

end
