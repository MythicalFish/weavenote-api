class SpecSheetController < ApplicationController

  before_action :set_project, only: [:export_to_pdf]
  skip_before_action :initialize_user!, only: [:test]
  skip_before_action :check_ability!, only: [:test]

  def export_to_pdf
    spec_sheet = SpecSheet.new(pdf_name, @project)
    file = spec_sheet.create_pdf
    storage = Fog::Storage.new( Rails.configuration.fog )
    headers = { "Content-Type" => 'application/pdf', "x-amz-acl" => "public-read" }
    s = storage.put_object(ENV['WEAVENOTE__AWS_S3_BUCKET'], "#{pdf_path}#{pdf_name}", file, headers )
    url = "https://#{s.host}#{s.path}"
    render json: { url: url }
  end

  def test
    return nil if Rails.env.production?
    @project = Project.last
    pdf = SpecSheet.new(pdf_name, @project).create_pdf
    f = File.read(pdf)
    send_data pdf, filename: 'test.pdf', type: :pdf, disposition: :inline
  end

  private

  def pdf_name
    t = Time.now.strftime('%Y-%m-%d_%H-%M')
    "#{@project.name.split(' ').join('-')}__#{t}.pdf"
  end

  def pdf_path
    'weavenote/exports/'
  end

  def set_project
    @project = @user.projects.find(params[:project_id])
  end

end
