# Class for files who are going to have their includes merged in
class AdocFile
  attr_accessor :text, :includes, :parent_dir, :filename, :file, :out_fn

  def initialize(filename)
    @file = filename
    @parent_dir = File.dirname(filename)
    @text = File.open(filename).read
    gather_includes
  end

  def gather_includes
    return unless includes?

    incl_re = /^include::(.*?)\.(adoc|asciidoc)\[(.*?)\]/
    incl_list = @text.to_enum(:scan, incl_re).map { Regexp.last_match }
    @includes = process_incl_list(incl_list)
  end

  def merge_includes
    @includes.map do |line, file, offset|
      included_file = AdocFile.new("#{parent_dir}/#{file}")

      @text.sub!(line, included_file.text) unless offset != 0

      offset_text = if offset.positive?
                      [":leveloffset: +#{offset}", ":leveloffset: -#{offset}"]
                    else
                      [":leveloffset: #{offset}", ":leveloffset: +#{offset * -1}"]
                    end

      @text.sub!(line, "#{offset_text[0]}\n\n#{included_file.text}\n\n#{offset_text[1]}")
    end
  end

  def save_back_to_file
    @out_fn = @file
    File.open(@out_fn, 'w') { |f| f.write(@text) }
  end

  def save_to_new_file
    fn_parts = @file.split('.')
    extension = fn_parts.pop
    @out_fn = "#{fn_parts.join('.')}_.#{extension}"
    File.open(@out_fn, 'w') { |f| f.write(@text) }
  end

  private

  def includes?
    incl_re = /^include::(.*?)\.(adoc|asciidoc)\[(.*?)\]/
    !!incl_re.match(@text)
  end

  def process_incl_list(match_list)
    nil unless match_list

    match_list.map do |match|
      stub = match[1] # file name
      ext = match[2] # extension
      attrs = match[3] # leveloffset, if any

      [match[0], "#{stub}.#{ext}", 0] unless attrs.match(/leveloffset=/)
      [match[0], "#{stub}.#{ext}", attrs.split('=')[-1].to_i]
    end
  end
end
