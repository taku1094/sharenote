class CreateTimetables < ActiveRecord::Migration[5.1]
  def change
    create_table :timetables do |t|
      t.string :term
      t.string :user_id
      t.text :memo

      t.timestamps
    end
  end
end
