class CurrenciesController < ApplicationController

  # GET /currencies
  def index
    @currencies = Currency.to_hash
    render json: @currencies
  end

end
