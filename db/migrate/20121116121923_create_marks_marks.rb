class CreateMarksMarks < ActiveRecord::Migration
  def change
    create_table :marks_marks do |t|
      t.references :marker, polymorphic: true
      t.references :markable, polymorphic: true
      t.string :type
      t.timestamps
    end
    add_index :marks_marks, [:type, :markable_type, :markable_id]
  end
end
