require 'merger'
require 'tempfile'  # type: ignore

describe AdocFile do
  let(:test_parent_adoc) do
    Tempfile.new('adoc').tap do |f|
      f << "= My Asciidoc File

include::example_child_1.adoc

include::example_child_2.asciidoc

include::example_data.csv"
      f.close
    end
  end

  after do
    test_parent_adoc.unlink
  end

  describe '#includes?' do
    it 'returns true if there are includes in the file' do
      parent = AdocFile.new(test_parent_adoc.path)
      expect(parent.includes?).to eql(true)
    end
  end

  describe '#gather_includes' do
    it 'returns an array of included asciidoc files' do
      parent = AdocFile.new(test_parent_adoc.path)
      expect(parent.gather_includes).to eql(['example_child_1.adoc',
                                             'example_child_2.asciidoc'])
    end
  end
end
