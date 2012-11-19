class CreateMarksMarks < ActiveRecord::Migration
  def change
    create_table :marks_marks do |t|
      t.references :marker, polymorphic: true
      t.references :markable, polymorphic: true
      t.string :mark_type
      t.timestamps
    end
    add_index :marks_marks, [:mark_type, :markable_type, :markable_id]
  end
end
