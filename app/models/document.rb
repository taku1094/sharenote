class Document < ApplicationRecord
    validates :note_id,presence: true
    validates :timetable_id,presence: true
    validates :lecture_id,presence: true
end
