module Marks
  module RelationExtension
    attr_accessor :marker_value, :mark_type_values

    def self.included(klass)
      klass.class_eval do
        alias_method_chain :exec_queries, :marks
      end
    end

    def preload_marker(marker, *mark_types)
      self.marker_value     = marker
      self.mark_type_values = mark_types
      self
    end

    private

    def exec_queries_with_marks
      records = exec_queries_without_marks

      if marker_value.present? && mark_type_values.present?
        mark_type_values.each do |mark_type|
          preload_marker_for(records, marker_value, mark_type)
        end
      end

      records
    end

    def preload_marker_for(records, marker, mark_type)
      markable_ids = Mark.where(markable: records, marker: marker, mark_type: mark_type.to_s.classify).pluck(:markable_id)

      records.each do |record|
        record.association(:"#{mark_type}_marked_flag").target = markable_ids.include?(record.id)
      end
    end
  end
end
