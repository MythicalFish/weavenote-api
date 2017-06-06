class CareLabelsController < ApplicationController

  # GET /care_labels
  def index
    @labels = CareLabel.all
    render json: @labels
  end

end
