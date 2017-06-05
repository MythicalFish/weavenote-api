class ApplicationController < ActionController::API
  
  include SetUser

  def root
    render json: {}
  end

  def stats
    @projects = @organization.projects.active
    response = {
      projects: {
        counts: {
          active: @projects.length,
          recently_active: @projects.where(updated_at: (Time.now - 1.day)..Time.now).length,
          by_stage: []
        },
      }
    }
    DevelopmentStage.all.each do |s|
      stage_count = @projects.where(development_stage_id: s.id).length
      response[:projects][:counts][:by_stage] <<
        { label: s.label, count: stage_count }
    end
    render json: response
  end

end
