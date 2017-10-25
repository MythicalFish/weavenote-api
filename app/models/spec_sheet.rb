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

  def initialize(filename, project, options)
    @filename = filename
    @project = project
    @options = options
  end

  def config
    {
      page_size: 'A4',
      orientation: 'Landscape',
      margin_top: 0,
      margin_right: 0,
      margin_bottom: 0,
      margin_left: 0,
      print_media_type: true,
      disable_smart_shrinking: ENV['DISABLE_PDF_SHRINK'] ? true : false,
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
  
  def html options
    ActionController::Base.new.render_to_string(
      "spec_sheet/index.html.erb", 
      locals: { 
        :@project => @project,
        :@options => @options
      }
    )
  end

end
