require 'marks/engine'
require 'marks/marker'
require 'marks/markable'

module Marks
end

# load Rails/Railtie
begin
  require 'rails'
rescue LoadError
  #do nothing
end
