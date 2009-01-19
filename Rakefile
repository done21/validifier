require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('validifier', '0.1.1') do |p|
  p.description    = "Generate flash embed code that is valid XHTML"
  p.url            = "http://github.com/done21/validifier"
  p.author         = "Jim Hoskins"
  p.email          = "jim@done21.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
  p.runtime_dependencies = ["hpricot", "htmlentities"]
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }

