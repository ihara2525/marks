module Marks
  module Marker
    extend ActiveSupport::Concern

    module ClassMethods
      def marks_with(*types)
        has_many :outgoing_marks, as: :marker, dependent: :destroy, class_name: 'Marks::Mark'

        class_eval do
          define_method :'marks' do |markable, mark, options = {}|
            classified_mark = mark.to_s.classify
            raise ArgumentError unless types.map { |t| t.to_s.classify }.include?(classified_mark)
            return if options[:unique] && self.marks?(markable, mark)
            Marks::Mark.create do |c|
              c.mark_type = classified_mark
              c.marker = self
              c.markable = markable
            end
          end

          define_method :'marks?' do |markable, mark|
            classified_mark = mark.to_s.classify
            raise ArgumentError unless types.map { |t| t.to_s.classify }.include?(classified_mark)
            outgoing_marks.where(mark_type: classified_mark, markable_type: markable.class.table_name.classify, markable_id: markable).any?
          end

          define_method :'unmarks' do |markable, mark|
            classified_mark = mark.to_s.classify
            raise ArgumentError unless types.map { |t| t.to_s.classify }.include?(classified_mark)
            outgoing_marks.where(mark_type: classified_mark, markable_type: markable.class.table_name.classify, markable_id: markable).destroy_all
          end

          define_method :'markings' do |markable_class, mark|
            classified_mark = mark.to_s.classify
            raise ArgumentError unless types.map { |t| t.to_s.classify }.include?(classified_mark)
            outgoing_marks.where(mark_type: classified_mark, markable_type: markable_class.to_s.constantize.table_name.classify)
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, Marks::Marker
