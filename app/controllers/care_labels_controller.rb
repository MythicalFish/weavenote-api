class CareLabelsController < ApplicationController

  # GET /care_labels
  def index
    @labels = CareLabel.all.order('label ASC')
    render json: @labels
  end

end
