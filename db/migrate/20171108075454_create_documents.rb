class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :note_id
      t.string :timetable_id
      t.string :lecture_id

      t.timestamps
    end
  end
end
