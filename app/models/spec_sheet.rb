class PDFKitHeadless < PDFKit
  def command path = nil
    if Rails.env.production?
      # prefix with xvfb in production to get it working
      return 'xvfb-run ' + super
    else
      return super
    end
  end
end

class SpecSheet

  def initialize(filename, project)
    @filename = filename
    @project = project
  end

  def config
    {
      page_size: 'A4',
      orientation: 'Landscape',
      margin_top: 0,
      margin_right: 0,
      margin_bottom: 0,
      margin_left: 0,
      disable_smart_shrinking: Rails.env.development?,
      print_media_type: true,
      dpi: 300
    }
  end

  def create_pdf
    filepath = "#{Rails.root}/tmp/#{@filename}"
    kit = PDFKitHeadless.new(html, self.config)
    kit.stylesheets << "#{Rails.root}/lib/pdfkit/style.css"
    kit.to_file(filepath)
  end

  private

  def html
    ActionController::Base.new.render_to_string("pdfkit/template.html.erb", locals: { :@project => @project})
  end

end
