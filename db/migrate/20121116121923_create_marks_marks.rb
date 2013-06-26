class CreateMarksMarks < ActiveRecord::Migration
  def change
    create_table :marks_marks do |t|
      t.references :marker, polymorphic: true
      t.references :markable, polymorphic: true
      t.string :mark_type
      t.timestamps
    end
    add_index :marks_marks, [:mark_type, :markable_type, :markable_id], name: 'index_marks_marks_on_mk_type_and_mkbl_type_and_mkbl_id'
  end
end
