class CreateLectures < ActiveRecord::Migration[5.1]
  def change
    create_table :lectures do |t|
      t.string :name
      t.string :date
      t.string :time
      t.string :professor
      t.string :room
      t.text :memo
      t.string :term
      t.string :user_id

      t.timestamps
    end
  end
end
