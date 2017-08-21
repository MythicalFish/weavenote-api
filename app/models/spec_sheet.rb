class SpecSheet

  def initialize(filename, project)
    @filename = filename
    @project = project
  end

  def config
    {
      orientation: 'Landscape',
    }
  end

  def create_pdf
    filepath = "#{Rails.root}/tmp/#{@filename}"
    kit = PDFKit.new(html, self.config)
    kit.stylesheets << "#{Rails.root}/lib/pdfkit/style.css"
    kit.to_file(filepath)
  end

  private

  def html
    ActionController::Base.new.render_to_string("pdfkit/template.html.erb", locals: { :@project => @project})
  end

end
