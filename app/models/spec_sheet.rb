class SpecSheet

  require 'pandoc-ruby'

  def initialize(project, filename)
    @project = project
    @filename = filename
  end

  def config
    [
      'geometry:top=0.8in,right=0.8in,bottom=1.2in,left=0.8in,footskip=0.6in',
      'documentclass:scrartcl',
      'fontsize:17pt',
      "mainfont:'Source Sans Pro'",
      "sansfont:'Source Sans Pro'",
      "colorlinks:'true'",

      "title-meta:'#{@project.name}'",
      "title:'#{@project.name}'",
      "author-meta:'Weavenote'"

    ].join(' -V ')
  end

  def markdown
    c = ''
    c << "# #{@project.name}\n\n"
    c
  end

  def create_pdf

    filepath = "#{Rails.root}/tmp/#{@filename}"

    PandocRuby.convert(
      self.markdown,
      :s, {
        :V => self.config,
        :from => :markdown,
        :o => filepath
      },
      'template' => Rails.root.join('lib','pandoc','template.tex'),
      'latex-engine' => 'xelatex'
    )

    return filepath

  end

end
