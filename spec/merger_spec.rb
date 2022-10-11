require 'merger'
require 'tempfile'

describe AdocFile do
  parent_file = 'spec/support/example_parent.adoc'
  edgecases_file = 'spec/support/example_edgecases.adoc'

  describe '#includes?' do
    it 'returns true if there are includes in the file' do
      parent = AdocFile.new(parent_file)
      expect(parent.includes?).to eql(true)
    end
  end

  describe '#gather_includes' do
    it 'returns an array of included asciidoc files and offsets' do
      parent = AdocFile.new(parent_file)
      expect(parent.gather_includes).to eql([['example_child.adoc', 0],
                                             ['example_child_2.asciidoc', 1]])
    end

    it 'handles negative offsets' do
      parent = AdocFile.new(edgecases_file)
      expect(parent.gather_includes).to eql([['some-file.adoc', -44]])
    end

  end
end
