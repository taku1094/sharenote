class Lecture < ApplicationRecord
    belongs_to :timetable
    validates :term,presence: true
    validates :date,presence: true
    validates :name,presence: true
    validates :time,presence: true
    validates :user_id,presence: true
end
