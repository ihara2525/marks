module Marks
  class Mark < ActiveRecord::Base
    belongs_to :marker, polymorphic: true
    belongs_to :markable, polymorphic: true
  end
end
