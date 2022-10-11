require 'merger'
require 'tempfile'  # type: ignore

describe AdocFile do
  parent_file = 'spec/support/example_parent.adoc'

  describe '#includes?' do
    it 'returns true if there are includes in the file' do
      parent = AdocFile.new(parent_file)
      expect(parent.includes?).to eql(true)
    end
  end

  describe '#gather_includes' do
    it 'returns an array of included asciidoc files' do
      parent = AdocFile.new(parent_file)
      expect(parent.gather_includes).to eql(['example_child.adoc',
                                             'example_child_2.asciidoc'])
    end
  end
end
