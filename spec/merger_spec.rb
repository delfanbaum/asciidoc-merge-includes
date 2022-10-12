require 'merger'

parent_file = 'spec/support/example_parent.adoc'
edgecases_file = 'spec/support/example_edgecases.adoc'

describe AdocFile do
  before(:each) do
    @parent = AdocFile.new(parent_file)
  end

  describe '#intialize' do
    it 'has the expected attributes' do
      expect(@parent.text).to include('My Asciidoc File')
      expect(@parent.parent_dir).to include('spec/support')
      expect(@parent.includes.flatten.to_s).to include('example_child')
    end
  end

  describe '#gather_includes' do
    it 'returns an array of included asciidoc files and offsets' do
      expect(@parent.gather_includes).to eql([['include::example_child.adoc[]',
                                               'example_child.adoc', 0],
                                              ['include::example_child_2.asciidoc[leveloffset=+1]',
                                               'example_child_2.asciidoc', 1]])
    end

    it 'handles negative offsets' do
      edgecase = AdocFile.new(edgecases_file)
      expect(edgecase.gather_includes).to eql([['include::example_child.adoc[leveloffset=-44]',
                                                'example_child.adoc', -44]])
    end
  end
end

describe 'Merge functionality' do
  before(:each) do
    @parent = AdocFile.new(parent_file)
  end

  describe '.merge_includes' do
    it 'pulls in included content' do
      parent = AdocFile.new(parent_file)
      parent.merge_includes
      expect(parent.text).to include("I'm A Child File")
    end

    it 'handles negative offsets' do
      edgecase = AdocFile.new(edgecases_file)
      edgecase.merge_includes
      expect(edgecase.text).to include(':leveloffset: -44')
    end
  end
end
