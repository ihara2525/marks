require 'marks/engine'
require 'marks/marker'
require 'marks/markable'
require 'marks/relation_extension'

module Marks
end

# load Rails/Railtie
begin
  require 'rails'
rescue LoadError
  #do nothing
end

ActiveSupport.on_load(:active_record) do
  ActiveRecord::Relation.send(:include, Marks::RelationExtension)
end
