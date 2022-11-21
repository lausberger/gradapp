class CreateStudentChecklists < ActiveRecord::Migration
  def change
    create_table :student_checklists do |t|
      t.references :student, show: true, foreign_key: true
      t.boolean :citizenship, default: false
      t.boolean :research_area, default: false
      t.boolean :degree_objective, default: false
      t.boolean :ug_inst, default: false
      t.boolean :ug_gpa, default: false
      t.boolean :ug_degree, default: false
      t.boolean :ug_major, default: false
      t.boolean :ug_transcript, default: false
      t.boolean :grad_inst, default: false
      t.boolean :grad_gpa, default: false
      t.boolean :grad_degree, default: false
      t.boolean :grad_major, default: false
      t.boolean :grad_transcript, default: false
      t.boolean :letter_recommendations, default: false
      t.boolean :gre_scores, default: false
      t.boolean :language_scores, default: false
      t.boolean :resume, default: false
      t.boolean :sop, default: false

      t.timestamps null: false
    end
  end
end
