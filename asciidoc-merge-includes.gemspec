Gem::Specification.new do |s|
  s.name        = 'asciidoc-merge-includes'
  s.version     = '0.1.0'
  s.licenses    = ['MIT']
  s.summary     = 'A tool to merge "included" asciidoc files, because sometimes you need to do that.'
  s.description = 'Takes any number of asciidoc files as arguments, along with a flag or two, and ' \
                  'merges any includes it finds in those files into the files themselves or a new one.'
  s.authors     = ['Danny Elfanbaum']
  s.email       = 'drelfanbaum@gmail.com'
  s.files       = Dir['lib/*.rb'] + Dir['bin/*']
  s.executables << 'asciidoc-merge-includes'
  s.metadata    = { 'source_code_uri' => 'https://github.com/delfanbaum/asciidoc-merge-includes' }
  s.homepage    = 'https://github.com/delfanbaum/asciidoc-merge-includes'
  s.required_ruby_version = '>= 3.1'
end
