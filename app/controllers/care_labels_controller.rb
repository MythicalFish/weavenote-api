class CareLabelsController < ApplicationController

  # GET /care_labels
  def index
    @labels = CareLabel.all.order('name ASC')
    render json: @labels
  end

end
