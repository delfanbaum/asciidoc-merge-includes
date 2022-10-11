# Class for files who are going to have their includes merged in
class AdocFile
  attr_accessor :text, :includes

  def initialize(filename)
    @text = File.open(filename).read
  end

  def includes?
    !!/^include::/.match(@text)
  end

  def gather_includes
    return unless includes?

    incl_re = /include::(.*?)\.(adoc|asciidoc)/
    @includes = @text.scan(incl_re).map { |stub, ext| "#{stub}.#{ext}" }
  end
end
