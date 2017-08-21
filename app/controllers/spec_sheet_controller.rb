class SpecSheetController < ApplicationController

  before_action :set_project

  def export_to_pdf
    spec_sheet = SpecSheet.new(pdf_name, @project)
    file = spec_sheet.create_pdf
    storage = Fog::Storage.new( Rails.configuration.fog )
    headers = { "Content-Type" => 'application/pdf', "x-amz-acl" => "public-read" }
    s = storage.put_object(ENV['WEAVENOTE__AWS_S3_BUCKET'], pdf_name, file, headers )
    url = "https://#{s.host}#{s.path}"
    render json: { url: url }
  end

  private

  def pdf_name
    t = Time.now.strftime('%Y-%m-%d_%H-%M')
    "#{@project.name.split(' ').join('-')}__#{t}.pdf"
  end

  def set_project
    @project = @user.projects.find(params[:project_id])
  end

end
