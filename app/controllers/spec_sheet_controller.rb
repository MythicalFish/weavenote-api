class SpecSheetController < ApplicationController

  before_action :set_project, only: [:create]
  before_action :check_ability!, only: [:create]
  skip_before_action :initialize_user!, only: [:test]

  def create
    file = SpecSheet.new(pdf_name, @project, spec_sheet_params).create_pdf
    storage = Fog::Storage.new( Rails.configuration.fog )
    headers = { "Content-Type" => 'application/pdf', "x-amz-acl" => "public-read" }
    s = storage.put_object(ENV['WEAVENOTE__AWS_S3_BUCKET'], "#{pdf_path}#{pdf_name}", file, headers )
    url = "https://#{s.host}#{s.path}"
    render json: { url: url }
  end

  def test
    return nil if Rails.env.production?
    @project = Project.last
    pdf = SpecSheet.new(pdf_name, @project, spec_sheet_params).create_pdf
    send_data pdf, filename: 'test.pdf', type: :pdf, disposition: :inline
  end

  private

  def spec_sheet_params
    # Set each export option as true if 'true' or not present
    opts = boolean_options.map { |p|
      [p,!params.key?(p) || params[p] == 'true']
    }.to_h.symbolize_keys
    # Set :comments as key if present (eg. 'Annotated')
    case params[:comments]
      when 'None'
      when 'false'
        opts[:comments] = false
      when 'Annotated'
        opts[:comments] = 'Annotated'
      else
        opts[:comments] = true
    end
    opts
  end

  def boolean_options
    [:measurements, :instructions, :materials, :secondary_images]
  end

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
